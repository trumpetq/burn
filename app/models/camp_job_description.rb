# == Schema Information
#
# Table name: camp_job_descriptions
#
#  id         :bigint           not null, primary key
#  status     :integer          not null
#  title      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class CampJobDescription < ApplicationRecord
  extend Enumerize

  include Stepable
  include Discard::Model

  enumerize :status, in: STATUSES.slice(:active), default: :active, predicates: true, scope: true

  validates :title, length: {in: 5..100}, presence: true
  validates :description, length: {in: 5..10_00}, presence: true

  has_many :camp_job_definitions, dependent: :restrict_with_error

  def to_s
    title&.truncate(30)
  end

  def multiple?
    true
  end

  def finished?
    active?
  end
end
