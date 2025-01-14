# == Schema Information
#
# Table name: camp_jobs
#
#  id                      :bigint           not null, primary key
#  all_day                 :boolean
#  approval_required       :boolean
#  approved_at             :datetime
#  assigned_at             :datetime
#  bay_area                :boolean
#  begin_at                :datetime
#  completed_at            :datetime
#  end_at                  :datetime
#  financial               :boolean
#  job_on                  :date
#  notes                   :text
#  points                  :decimal(5, 2)
#  private_notes           :text
#  rejected_at             :datetime
#  status                  :integer          not null
#  strong_person           :boolean
#  timeframe               :integer          not null
#  wap_required            :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  approved_by_id          :bigint
#  assigned_by_id          :bigint
#  camp_job_description_id :bigint
#  completed_by_id         :bigint
#  job_id                  :string
#  rejected_by_id          :bigint
#  user_id                 :bigint
#
# Indexes
#
#  index_camp_jobs_on_user_id  (user_id)
#
class CampJob < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active, :approved, :assigned, :completed, :rejected), default: :active, predicates: true, scope: true
  enumerize :timeframe, in: {pre_event: 10, build_week: 20, burn_week: 30, strike: 40, post_event: 50, year_round: 100}, default: :burn_week, predicates: true, scope: true

  before_validation :set_job_id

  validates :points, numericality: {in: 0..100}, presence: true
  validates :job_id, length: {is: 6}, uniqueness: true

  belongs_to :user, optional: true
  belongs_to :camp_job_description

  scope :for_camp_job_description, ->(camp_job_description) { where(camp_job_description: camp_job_description) }
  scope :for_job_id, ->(job_id) { where(job_id: job_id&.upcase) }
  scope :order_by_title, -> { includes(:camp_job_description).order("camp_job_descriptions.title ASC") }
  scope :order_by_date, -> { order(job_on: :asc, id: :asc) }
  scope :reorder_by_date, -> { reorder(job_on: :asc, id: :asc) }
  scope :in_bay_area, -> { where(bay_area: true) }
  scope :on_day, ->(date) { where(job_on: date) }

  def to_s
    "Job #{job_id}"
  end

  def to_label
    job_on_label = job_on.present? ? job_on.to_fs(:year_month_day) : "No day"
    "#{job_on_label}  - #{camp_job_description&.title} - #{job_id}".strip
  end

  def can_sign_up?
    user.blank? && active?
  end

  def title
    camp_job_description&.title
  end

  def multiple?
    true
  end

  def finished?
    approved? || completed?
  end

  def user_required?
    false
  end

  private

  def set_job_id
    return if job_id.present?

    loop do
      self.job_id = SecureRandom.hex(3).upcase
      break unless self.class.for_job_id(job_id).exists?
    end
  end
end
