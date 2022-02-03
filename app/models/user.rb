# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  country_code           :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  description            :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string           not null
#  phone_number           :string
#  playa_name             :string
#  postal_code            :string
#  previous_years         :jsonb            not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("guest"), not null
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          default("active"), not null
#  time_zone              :string           default("Pacific Time (US & Canada)"), not null
#  title                  :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  include Roleable
  extend Enumerize

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :lockable

  phony_normalize :phone_number, default_country_code: "US"

  enumerize :role, in: {guest: 0, member: 1, camper: 2, leader: 5, mayor: 10}, default: :guest, predicates: true, scope: true
  enumerize :status, in: {active: 0, confirmed: 1, banned: 10}, default: :active, predicates: true, scope: true

  validates :name, :role, :status, :time_zone, presence: true
  validates :phone_number, phony_plausible: true

  has_many :user_steps, -> { order(position: :asc) }

  scope :for_phone_number, ->(phone_number) { where(phone_numer: PhonyRails.normalize_number(phone_number)) }

  after_create :set_role, :generate_steps

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

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.iso_short_name
  end

  def generate_steps
    ::Step.all.each do
      ::UserStep.create!(
        user: self,
        step: _1,
        type: _1.step_type,
        position: _1.position,
        status: _1.status
      )
    end
  end

  private

  def set_role
    update(role: :member) if guest?
  end
end
