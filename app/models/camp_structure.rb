# == Schema Information
#
# Table name: camp_structures
#
#  id              :bigint           not null, primary key
#  approved_at     :datetime
#  assigned_at     :datetime
#  completed_at    :datetime
#  description     :text
#  length          :decimal(5, 2)
#  map             :boolean
#  notes           :text
#  private_notes   :text
#  rejected_at     :datetime
#  status          :integer          not null
#  structure       :integer
#  width           :decimal(5, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  approved_by_id  :bigint
#  assigned_by_id  :bigint
#  completed_by_id :bigint
#  rejected_by_id  :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_camp_structures_on_user_id  (user_id)
#
class CampStructure < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active, :assigned, :approved, :completed, :rejected), default: :active, predicates: true, scope: true

  enumerize :structure, in: {not_sure: 0, tent: 1, carport: 5, hexayurt: 10, monkey_hut: 15, shiftpod: 20, other: 100}, predicates: true, scope: true

  belongs_to :user

  validates :structure, presence: true
  validates :length, numericality: {in: 0..100}, presence: true
  validates :width, numericality: {in: 0..100}, presence: true
  validates :description, length: {maximum: 2_000}, allow_blank: false

  scope :on_map, -> { where(map: true) }
end
