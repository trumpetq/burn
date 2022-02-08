module Stepable
  extend ActiveSupport::Concern

  included do
    validates :user_id, uniqueness: true

    belongs_to :user

    scope :for_user, ->(user) { where(user: user) }
  end

  def to_s
    "Camp application ##{id}"
  end

  def to_log
    "Camp application id=#{id}, user_id=#{user_id}"
  end
end
