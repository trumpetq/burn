# == Schema Information
#
# Table name: user_steps
#
#  id               :bigint           not null, primary key
#  applied_at       :datetime
#  completed_at     :datetime
#  position         :integer
#  referral_name    :string
#  status           :integer          default("unavailable"), not null
#  stepable_type    :string
#  type             :string
#  what_excites_you :text
#  who_are_you      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  step_id          :bigint
#  stepable_id      :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_user_steps_on_step_id   (step_id)
#  index_user_steps_on_stepable  (stepable_type,stepable_id)
#  index_user_steps_on_user_id   (user_id)
#
class CampJob < UserStep

end
