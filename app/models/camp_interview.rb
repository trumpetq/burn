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
#  private_notes     :text
#  rejected_at       :datetime
#  skipped_at        :bigint
#  status            :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  approved_by_id    :bigint
#  completed_by_id   :bigint
#  interviewed_by_id :bigint
#  rejected_by_id    :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_camp_interviews_on_discarded_at  (discarded_at)
#  index_camp_interviews_on_user_id       (user_id)
#
class CampInterview < ApplicationRecord
  include Discard::Model
end
