# == Schema Information
#
# Table name: camp_job_definitions
#
#  id                      :bigint           not null, primary key
#  all_day                 :boolean
#  approval_required       :boolean
#  begin_at                :datetime
#  east_bay                :boolean
#  end_at                  :datetime
#  financial               :boolean
#  job_on                  :date
#  notes                   :text
#  points                  :decimal(4, 2)
#  private_notes           :text
#  status                  :integer          not null
#  strong_person           :boolean
#  timeframe               :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  camp_job_description_id :bigint
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_camp_job_definitions_on_user_id  (user_id)
#
class CampJobDefinition < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active), default: :active, predicates: true, scope: true
  enumerize :timeframe, in: {burn_week: 1, pre_event: 10, build_week: 20, teardown: 30, post_event: 50, year_round: 100}, default: :burn_week, predicates: true, scope: true

  validates :points, numericality: {in: 0..100}

  belongs_to :camp_job_description
  has_one :camp_job, dependent: :destroy

  scope :for_camp_job_description, ->(camp_job_description) { where(camp_job_description: camp_job_description)}
  scope :order_by_title, -> { includes(:camp_job_description).order("camp_job_descriptions.title ASC") }

  def to_s
    "Job definition #{id}"
  end

  def to_label
    job_on_label = job_on.present? ? job_on.to_fs(:year_month_day) : "No day"
    "#{job_on_label}  - #{camp_job_description&.title}".strip
  end

  def title
    camp_job_description&.title
  end

  def multiple?
    true
  end

  def finished?
    active?
  end
end
