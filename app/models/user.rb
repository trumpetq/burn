# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allergies              :text
#  born_on                :date
#  country_code           :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  description            :text
#  diet                   :integer
#  discarded_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_url           :text
#  failed_attempts        :integer          default(0), not null
#  instagram_url          :text
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string           not null
#  phone_number           :string
#  plan                   :integer          not null
#  playa_name             :string
#  postal_code            :string
#  previous_years         :jsonb
#  private_notes          :text
#  pronouns               :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          not null
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          not null
#  tiktok_url             :text
#  time_zone              :string           default("Pacific Time (US & Canada)"), not null
#  title                  :string
#  twitter_url            :text
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at          (discarded_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  extend Enumerize

  include Roleable
  include Sociable
  include Discard::Model

  COMPLETE_PROFILE_FIELDS = [:diet, :born_on, :country_code, :description, :name, :phone_number, :postal_code, :pronouns, :time_zone].freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :lockable

  phony_normalize :phone_number, default_country_code: "US"

  enumerize :role, in: {guest: 0, member: 1, camper: 2, leader: 5, mayor: 10}, default: :guest, predicates: true, scope: true
  enumerize :status, in: {active: 0, confirmed: 1, banned: 10}, default: :active, predicates: true, scope: true
  enumerize :plan, in: {none: 0, camping_with_us: 1, thinking_about_it: 2, camping_elsewhere: 3, not_going: 10}, default: :none, predicates: true, scope: true
  enumerize :pronouns, in: {he_him: 1, she_her: 2, they_them: 3, she_they: 4, he_they: 5, all: 10}, predicates: true, scope: true
  enumerize :diet, in: {omnivore: 1, vegitarian: 2, vegan: 3}, predicates: true, scope: true

  validates :name, :role, :status, :time_zone, presence: true
  validates :phone_number, phony_plausible: true
  validates :private_notes, length: {maximum: 10_000}

  has_one_attached :avatar do |attachable|
    attachable.variant :menu, resize_to_fill: [100, 100]
    attachable.variant :thumbnail, resize_to_limit: [300, 300]
    attachable.variant :profile, resize_to_limit: [1000, 1000]
  end

  has_one :camp_application
  has_one :camp_deposit
  has_one :camp_due
  has_one :camp_interview
  has_one :camp_vehicle
  has_one :camp_structure
  has_one :camp_work_access_pass
  has_one :newsletter

  has_many :camp_interviews, foreign_key: :interviewed_by_id, class_name: ::CampInterview.name
  has_many :camp_jobs
  has_many :camp_tickets

  scope :for_id, ->(id) { where(id: id) }
  scope :for_phone_number, ->(phone_number) { where(phone_numer: PhonyRails.normalize_number(phone_number)) }
  scope :for_email, ->(email) { where(email: email&.downcase&.squish) }
  scope :like_email, ->(email) { where("email LIKE ?", "%#{email&.downcase&.squish}%") }
  scope :like_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name&.downcase&.squish}%") }
  scope :in_bay_area, -> { where(postal_code: Settings.postal_code.bay_area) }
  scope :order_by_name, -> { order("LOWER(name) ASC") }
  scope :not_camping_with_us, -> { with_plan(:camping_elsewhere, :not_goin) }

  before_validation :scrub_previous_years
  before_validation :normalize_attributes
  after_create :set_role, :create_newsletter

  def to_s
    display_name
  end

  def to_log
    "User id=#{id}, email=#{email}"
  end

  def age
    return unless born_on.present?

    now = Time.current.to_date
    now.year - born_on.year - (now.month > born_on.month || (now.month == born_on.month && now.day >= born_on.day) ? 0 : 1)
  end

  def display_name
    return playa_name if playa_name.present?
    return name if name.present?
    return "User ##{id}" if id.present?
    "Guest"
  end

  def full_name
    n = name
    n = "#{name} (#{playa_name})" if playa_name.present?
    n
  end

  def country_name
    return if country_code.blank?
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.iso_short_name
  end

  def complete_profile?
    missing_fields.empty?
  end

  def incomplete_profile?
    !complete_profile?
  end

  def should_edit_profile?
    incomplete_profile? || !avatar.attached?
  end

  def missing_fields
    COMPLETE_PROFILE_FIELDS.filter { !send(_1).present? }
  end

  def might_camp_with_us?
    plan.none? || plan.camping_with_us? || plan.thinking_about_it?
  end

  def in_bay_area?
    return false unless postal_code.present? && country_code == "US"
    Settings.postal_code.bay_area.include?(postal_code)
  end

  def social_media?
    facebook_url.present? || instagram_url.present? || twitter_url.present?
  end

  def active_for_authentication?
    super && !discarded?
  end

  def has_ticket?
    camp_tickets.with_ticket_type(:ticket).with_availability(:using_myself).exists?
  end

  def can_apply?
    !status.banned?
  end

  def can_interview?
    camp_application&.finished?
  end

  def can_confirm?
    camp_application&.finished? && camp_interview&.finished? && camp_due&.finished? && camp_deposit&.finished? && jobs_complete? && complete_profile?
  end

  def can_pay_dues?
    camp_application&.finished? && camp_interview&.finished?
  end

  def can_pay_deposit?
    can_pay_dues? && (camp_due&.finished? || camp_due&.paid?)
  end

  def can_sign_up_job?
    camp_application&.finished? && camp_interview&.finished? && camp_due&.finished?
  end

  def can_sign_up_wap?
    can_sign_up_job?
  end

  def jobs_complete?
    total_points >= Settings.camp.min_points
  end

  def has_interviews?
    camp_interviews.size.positive?
  end

  def total_points
    @total_points ||= camp_jobs&.sum(:points).to_f
  end

  private

  def set_role
    update(role: :member) if guest?
  end

  def create_newsletter
    nl = ::Newsletter.for_email(email).take

    if nl.present?
      nl.update(user: self, list: :general)
    else
      ::Newsletter.create(email: email, user: self, list: :general)
    end
  end

  def scrub_previous_years
    previous_years.reject!(&:blank?)
  end

  def normalize_attributes
    self.name = name&.strip
    self.playa_name = playa_name&.strip
    self.email = email&.strip&.downcase
  end
end
