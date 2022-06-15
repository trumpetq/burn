module Stepable
  extend ActiveSupport::Concern
  STATUSES = {unavailable: 0, active: 1, closed: 10, approved: 15, completed: 20, rejected: 30, skipped: 40, assigned: 50, paid: 60, no_response: 70, refunded: 80}.freeze

  included do
    attribute :send_email, :boolean, default: true

    validates :user_id, uniqueness: true, unless: :multiple?

    belongs_to :user
    belongs_to :approved_by, class_name: ::User.name, optional: true
    belongs_to :assigned_by, class_name: ::User.name, optional: true
    belongs_to :closed_by, class_name: ::User.name, optional: true
    belongs_to :completed_by, class_name: ::User.name, optional: true
    belongs_to :no_response_by, class_name: ::User.name, optional: true
    belongs_to :paid_by, class_name: ::User.name, optional: true
    belongs_to :refunded_by, class_name: ::User.name, optional: true
    belongs_to :rejected_by, class_name: ::User.name, optional: true
    belongs_to :skipped_by, class_name: ::User.name, optional: true

    scope :for_user, ->(user) { where(user: user) }
  end

  def to_s
    self.class.name.underscore.delete_prefix("camp_").humanize
  end

  def to_log
    "#{self.class.name.underscore.humanize} id=#{id}, user_id=#{user_id}"
  end

  def to_s_with_id
    "#{self} ##{id}"
  end

  def multiple?
    false
  end

  def finished?
    try(:completed?) || try(:approved?) || try(:skipped?)
  end
end
