# == Schema Information
#
# Table name: camp_job_definitions
#
#  id                      :bigint           not null, primary key
#  all_day                 :boolean
#  approval_required       :boolean
#  begin_at                :datetime
#  description             :text
#  east_bay                :boolean
#  end_at                  :datetime
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
  include Discard::Model

  enumerize :status, in: STATUSES.slice(:active), default: :active, predicates: true, scope: true
  enumerize :timeframe, in: {event: 1, pre_event: 2, post_event: 3}, default: :event, predicates: true, scope: true

  belongs_to :camp_job_description
  has_many :camp_jobs, dependent: :destroy

  def multiple?
    true
  end

  def finished?
    active?
  end
end
