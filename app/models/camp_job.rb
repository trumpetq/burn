# == Schema Information
#
# Table name: camp_jobs
#
#  id                     :bigint           not null, primary key
#  approved_at            :datetime
#  assigned_at            :datetime
#  begin_at               :datetime
#  completed_at           :datetime
#  end_at                 :datetime
#  job_on                 :date
#  notes                  :text
#  private_notes          :text
#  rejected_at            :datetime
#  status                 :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  approved_by_id         :bigint
#  assigned_by_id         :bigint
#  camp_job_definition_id :bigint           not null
#  completed_by_id        :bigint
#  rejected_by_id         :bigint
#  user_id                :bigint           not null
#
# Indexes
#
#  index_camp_jobs_on_user_id  (user_id)
#
class CampJob < ApplicationRecord
  extend Enumerize

  include Stepable
  include Discard::Model

  enumerize :status, in: STATUSES.slice(:unavailable, :active, :approved, :assigned, :completed, :rejected), default: :active, predicates: true, scope: true

  belongs_to :camp_job_definition

  def multiple?
    true
  end

  def finished?
    assigned? || completed?
  end
end
