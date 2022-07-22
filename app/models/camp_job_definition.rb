# == Schema Information
#
# Table name: camp_job_definitions
#
#  id                :bigint           not null, primary key
#  all_day           :boolean
#  approval_required :boolean
#  description       :text
#  east_bay          :boolean
#  notes             :text
#  points            :decimal(4, 2)
#  private_notes     :text
#  status            :integer          not null
#  strong_person     :boolean
#  timeframe         :integer          not null
#  title             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_camp_job_definitions_on_user_id  (user_id)
#
class CampJobDefinition < ApplicationRecord
  extend Enumerize

  include Stepable
  include Discard::Model

  enumerize :status, in: STATUSES.slice(:unavailable, :active), default: :active, predicates: true, scope: true
  enumerize :timeframe, in: {unavailable: 0, event: 1, pre_event: 2, post_event: 3}, predicates: true, scope: true

  has_many :camp_jobs, dependent: :destroy

  def multiple?
    true
  end

  def finished?
    active?
  end
end
