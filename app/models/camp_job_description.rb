# == Schema Information
#
# Table name: camp_job_descriptions
#
#  id          :bigint           not null, primary key
#  department  :integer
#  description :text             not null
#  status      :integer          not null
#  title       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
class CampJobDescription < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active), default: :active, predicates: true, scope: true
  enumerize :department, in: {none: 0, kitchen: 5, build: 10, power: 15, fun: 20, bureaucracy: 25, moop: 30}, default: :none, predicates: true, scope: true

  validates :title, length: {in: 5..100}, presence: true
  validates :description, length: {in: 5..10_00}, presence: true

  belongs_to :user
  has_many :camp_jobs, dependent: :restrict_with_error

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
