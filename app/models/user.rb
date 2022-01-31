# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string           not null
#  phone_number           :string
#  playa_name             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role_enum              :integer          default("guest"), not null
#  sign_in_count          :integer          default(0), not null
#  status_enum            :integer          default(0), not null
#  time_zone              :string           default("Pacific Time (US & Canada)"), not null
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

  enumerize :role_enum, in: {guest: 0, member: 1, camper: 2, leader: 5, mayor: 10}, default: :guest, predicates: true, scope: true
  enumerize :status_enum, in: {active: 0, confirmed: 1, banned: 10}, default: :active, predicates: true, scope: true

  validates :name, :role_enum, :status_enum, :time_zone, presence: true
  validates :phone_number, phony_plausible: true

  scope :for_phone_number, ->(phone_number) { where(phone_numer: PhonyRails.normalize_number(phone_number)) }

  after_create :set_role

  def to_s
    name
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

  def leader_or_above?
    leader? || mayor?
  end

  def member_or_above?
    member || leader? || mayor?
  end

  private

  def set_role
    update(role_enum: :member) if guest?
  end
end
