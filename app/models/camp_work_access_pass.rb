# == Schema Information
#
# Table name: camp_work_access_passes
#
#  id                  :bigint           not null, primary key
#  approval_required   :boolean
#  approved_at         :datetime
#  assigned_at         :datetime
#  expected_arrival_on :date
#  notes               :text
#  pass_on             :date
#  private_notes       :text
#  rejected_at         :datetime
#  status              :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  approved_by_id      :bigint
#  assigned_by_id      :bigint
#  rejected_by_id      :bigint
#  ticket_id           :text
#  user_id             :bigint
#
# Indexes
#
#  index_camp_work_access_passes_on_user_id  (user_id)
#
class CampWorkAccessPass < ApplicationRecord
  extend Enumerize

  include Stepable
  include Validatable

  enumerize :status, in: STATUSES.slice(:active, :approved, :assigned, :rejected), default: :active, predicates: true, scope: true

  validates :pass_on, presence: true
  validates :expected_arrival_on, date: {after_or_equal_to: :pass_on}

  has_one_attached :ticket

  validate :user_exists
  belongs_to :user, optional: true

  scope :order_by_date, -> { order(pass_on: :asc) }
  scope :reorder_by_date, -> { reorder(pass_on: :asc) }

  def to_s
    "WAP #{id}"
  end

  def can_sign_up?
    user.blank? && active?
  end

  def finished?
    approved? || assigned?
  end

  def user_required?
    false
  end
end
