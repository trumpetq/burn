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
class UserStep < ApplicationRecord
  extend Enumerize

  acts_as_list scope: :user_id

  validates :type, :step_id, uniqueness: {scope: :user_id}

  enumerize :status, in: {unavailable: 0, active: 1, closed: 10, completed: 20}, default: :unavailable, predicates: true, scope: true

  belongs_to :user
  belongs_to :step
  belongs_to :stepable, polymorphic: true, optional: true

  def complete!
    update(completed_at: Time.current, status: :completed)
  end

  def to_s
    step.name
  end

  def to_log
    "User step id=#{id}, step_id=#{step_id}"
  end
end
