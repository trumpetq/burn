# == Schema Information
#
# Table name: newsletters
#
#  id                :bigint           not null, primary key
#  discarded_at      :datetime
#  email             :string
#  list              :integer          not null
#  unsubscribe_token :string           not null
#  unsubscribed_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_newsletters_on_discarded_at       (discarded_at)
#  index_newsletters_on_email              (email) UNIQUE
#  index_newsletters_on_unsubscribe_token  (unsubscribe_token) UNIQUE
#  index_newsletters_on_user_id            (user_id) UNIQUE
#
class Newsletter < ApplicationRecord
  extend Enumerize

  include Discard::Model

  has_secure_token :unsubscribe_token, length: 36

  validates :email, presence: true
  validates :email, :unsubscribe_token, uniqueness: true
  validates :user_id, uniqueness: true, allow_blank: true

  enumerize :list, in: {unsubscribed: 0, general: 1, campers_only: 2}, default: :unsubscribed, predicates: true, scope: true

  belongs_to :user, optional: true

  scope :for_email, ->(email) { where(email: email&.downcase) }
  scope :for_user, ->(user) { where(user: user) }

  before_validation :set_unsubscribed_at

  def to_s
    email
  end

  def to_log
    "Newsletter id=#{id}, email=#{email}"
  end

  def unsubscribe!
    update!(list: :unsubscribed, unsubscribed_at: Time.current)
  end

  def subscribed?
    !unsubscribed?
  end

  private

  def set_unsubscribed_at
    self.unsubscribed_at = nil if list != :unsubscribed
    self.unsubscribed_at = Time.current if list == :unsubscribed && unsubscribed_at.blank?
  end
end
