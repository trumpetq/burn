# == Schema Information
#
# Table name: camp_interviews
#
#  id                :bigint           not null, primary key
#  applied_at        :datetime
#  approved_at       :datetime
#  assigned_at       :datetime
#  completed_at      :datetime
#  discarded_at      :datetime
#  feedback_notes    :text
#  initial_notes     :text
#  no_response_at    :datetime
#  private_notes     :text
#  rejected_at       :datetime
#  skipped_at        :datetime
#  status            :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  approved_by_id    :bigint
#  assigned_by_id    :bigint
#  completed_by_id   :bigint
#  interviewed_by_id :bigint
#  no_response_by_id :bigint
#  rejected_by_id    :bigint
#  skipped_by_id     :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_camp_interviews_on_discarded_at  (discarded_at)
#  index_camp_interviews_on_user_id       (user_id)
#
class CampInterview < ApplicationRecord
  extend Enumerize

  include Stepable
  include Discard::Model

  attr_accessor :action, :index

  validates :action, inclusion: {in: ["approved", "no_response", "rejected"]}, allow_nil: true

  enumerize :status, in: STATUSES.slice(:active, :approved, :assigned, :completed, :no_response, :rejected, :skipped), default: :active, predicates: true, scope: true

  validates :feedback_notes, :initial_notes, :private_notes, length: {maximum: 10_000}
  validates :interviewed_by, presence: true, if: :assigned?

  belongs_to :user
  belongs_to :interviewed_by, class_name: ::User.name, optional: true

  scope :for_interviewed_by, ->(interviewed_by) { where(interviewed_by: interviewed_by) }
end
