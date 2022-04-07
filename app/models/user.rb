# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  country_code           :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  description            :text
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
#  pronouns               :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          not null
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          not null
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
  include Discard::Model

  COMPLETE_PROFILE_FIELDS = [:country_code, :description, :name, :phone_number, :postal_code, :pronouns, :time_zone].freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :lockable

  phony_normalize :phone_number, default_country_code: "US"

  enumerize :role, in: {guest: 0, member: 1, camper: 2, leader: 5, mayor: 10}, default: :guest, predicates: true, scope: true
  enumerize :status, in: {active: 0, confirmed: 1, banned: 10}, default: :active, predicates: true, scope: true
  enumerize :plan, in: {none: 0, camping_with_us: 1, thinking_about_it: 2, camping_elsewhere: 3, not_going: 10}, default: :none, predicates: true, scope: true
  enumerize :pronouns, in: {he_him: 1, she_her: 2, they_them: 3, she_they: 4, he_they: 5, all: 10}, predicates: true, scope: true

  validates :name, :role, :status, :time_zone, presence: true
  validates :phone_number, phony_plausible: true
  validates :facebook_url, :twitter_url, :instagram_url, url: {allow_blank: true}

  has_one_attached :avatar do |attachable|
    attachable.variant :menu, resize_to_limit: [100, 100]
    attachable.variant :thumbnail, resize_to_limit: [300, 300]
    attachable.variant :profile, resize_to_limit: [1000, 1000]
  end

  has_one :camp_application
  has_one :camp_deposit
  has_one :camp_due
  has_one :camp_interview
  has_many :camp_interviews, foreign_key: :interviewed_by_id, class_name: ::CampInterview.name
  has_many :camp_tickets
  has_one :newsletter

  scope :for_phone_number, ->(phone_number) { where(phone_numer: PhonyRails.normalize_number(phone_number)) }
  scope :for_email, ->(email) { where(email: email&.downcase) }
  scope :in_bay_area, -> { where(postal_code: Settings.postal_code.bay_area) }
  scope :order_by_name, -> { order("LOWER(name) ASC") }

  before_validation :set_urls
  before_validation :scrub_previous_years
  before_validation :normalize_attributes
  after_create :set_role, :create_newsletter

  def to_s
    display_name
  end

  def to_log
    "User id=#{id}, email=#{email}"
  end

  def display_name
    return playa_name if playa_name.present?
    return name if name.present?
    return "User ##{id}" if id.present?
    "Guest"
  end

  def full_name
    full_name = name
    full_name = "#{full_name} (#{playa_name})" if playa_name.present?
    full_name
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

  def set_urls
    set_facebook_url
    set_instagram_url
    set_twitter_url
  end

  def set_facebook_url
    return if facebook_url.blank?
    return if facebook_url.match?(/\Ahttps?:\/\//)
    return if instagram_url.match?(/facebook\.com/)
    self.facebook_url = "https://www.facebook.com/#{facebook_url}"
  end

  def set_instagram_url
    return if instagram_url.blank?
    return if instagram_url.match?(/\Ahttps?:\/\//)
    return if instagram_url.match?(/instagram\.com/)
    self.instagram_url = "https://www.instagram.com/#{instagram_url}"
  end

  def set_twitter_url
    return if twitter_url.blank?
    return if twitter_url.match?(/\Ahttps?:\/\//)
    return if instagram_url.match?(/twitter\.com/)
    twitter_url.sub!("@", "")
    self.twitter_url = "https://twitter.com/#{twitter_url}"
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
