# == Schema Information
#
# Table name: steps
#
#  id           :bigint           not null, primary key
#  available_at :datetime
#  closed_at    :datetime
#  description  :text
#  name         :string           not null
#  status       :integer          default(0), not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Step < ApplicationRecord
  extend Enumerize

  enumerize :status, in: {unavailable: 0, active: 1, completed: 10}, default: :unavailable, predicates: true, scope: true

  validates :name, :short_description, presence: true

  belongs_to :user
  belongs_to :stepable, polymorphic: true

  def to_s
    name
  end

  def to_log
    "Step id=#{id}, name=#{name}"
  end
end
