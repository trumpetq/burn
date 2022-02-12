module Stepable
  extend ActiveSupport::Concern
  STATUSES = {unavailable: 0, active: 1, closed: 10, approved: 15, completed: 20, rejected: 30}.freeze

  included do
    validates :user_id, uniqueness: true

    belongs_to :user
    belongs_to :approved_by, class_name: ::User.name, optional: true
    belongs_to :completed_by, class_name: ::User.name, optional: true
    belongs_to :rejected_by, class_name: ::User.name, optional: true

    scope :for_user, ->(user) { where(user: user) }
  end

  def to_s
    "#{self.class.name.underscore.humanize} ##{id}"
  end

  def to_log
    "#{self.class.name.underscore.humanize} id=#{id}, user_id=#{user_id}"
  end
end
