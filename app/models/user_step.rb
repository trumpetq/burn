# == Schema Information
#
# Table name: user_steps
#
#  id            :bigint           not null, primary key
#  completed_at  :datetime
#  status        :integer          default(0), not null
#  stepable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  step_id       :bigint
#  stepable_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_user_steps_on_step_id   (step_id)
#  index_user_steps_on_stepable  (stepable_type,stepable_id)
#  index_user_steps_on_user_id   (user_id)
#
class UserStep < ApplicationRecord
  extend Enumerize

  enumerize :status, in: {unavailable: 0, active: 1, completed: 10}, default: :unavailable, predicates: true, scope: true

  belongs_to :user
  belongs_to :stepable, polymorphic: true

  def to_s
    name
  end

  def to_log
    "User step id=#{id}, name=#{name}"
  end
end
