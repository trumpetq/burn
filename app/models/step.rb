# == Schema Information
#
# Table name: steps
#
#  id                :bigint           not null, primary key
#  completed_at      :datetime
#  name              :string           not null
#  short_description :string
#  state_enum        :integer          default(0), not null
#  stepable_type     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stepable_id       :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_steps_on_stepable  (stepable_type,stepable_id)
#  index_steps_on_user_id   (user_id)
#
class Step < ApplicationRecord

  belongs_to :user


  def to_s
    name
  end

  def to_log
    "Step id=#{id}, name=#{name}"
  end
end
