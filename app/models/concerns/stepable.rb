module Stepable
  extend ActiveSupport::Concern
  STATUSES = {unavailable: 0, active: 1, closed: 10, approved: 15, completed: 20, rejected: 30, skipped: 40, assigned: 50}.freeze

  included do
    attribute :send_email, :boolean, default: true

    validates :user_id, uniqueness: true

    belongs_to :user
    belongs_to :approved_by, class_name: ::User.name, optional: true
    belongs_to :assigned_by, class_name: ::User.name, optional: true
    belongs_to :closed_by, class_name: ::User.name, optional: true
    belongs_to :completed_by, class_name: ::User.name, optional: true
    belongs_to :rejected_by, class_name: ::User.name, optional: true
    belongs_to :skipped_by, class_name: ::User.name, optional: true

    scope :for_user, ->(user) { where(user: user) }
  end

  def to_s
    "#{to_s_without_camp} #{id}"
  end

  def to_log
    "#{self.class.name.underscore.humanize} id=#{id}, user_id=#{user_id}"
  end

  def to_s_without_camp
    self.class.name.underscore.delete("camp_").humanize
  end
end
