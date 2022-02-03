# == Schema Information
#
# Table name: steps
#
#  id           :bigint           not null, primary key
#  available_at :datetime
#  closed_at    :datetime
#  description  :text
#  name         :string           not null
#  position     :integer
#  status       :integer          default("unavailable"), not null
#  step_type    :string
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Step < ApplicationRecord
  extend Enumerize

  acts_as_list

  enumerize :status, in: {unavailable: 0, active: 1, closed: 10}, default: :unavailable, predicates: true, scope: true

  validates :name, :title, presence: true

  def to_s
    name
  end

  def to_log
    "Step id=#{id}, name=#{name}"
  end
end
