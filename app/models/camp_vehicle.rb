# == Schema Information
#
# Table name: camp_vehicles
#
#  id              :bigint           not null, primary key
#  approved_at     :datetime
#  completed_at    :datetime
#  length          :decimal(5, 2)
#  licence_plate   :string
#  map             :boolean
#  notes           :text
#  private_notes   :text
#  rejected_at     :datetime
#  sleeping        :boolean
#  status          :integer          not null
#  trailer         :integer
#  vehicle         :integer
#  width           :decimal(5, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  approved_by_id  :bigint
#  completed_by_id :bigint
#  rejected_by_id  :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_camp_vehicles_on_user_id  (user_id)
#
class CampVehicle < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active, :approved, :completed, :rejected), default: :active, predicates: true, scope: true

  enumerize :vehicle, in: {no_vehicle: 0, car: 1, suv: 2, pickup_truck: 3, van: 4, small_box_truck: 20, medium_box_truck: 21, large_box_truck: 22, small_rv: 30, medium_rv: 31, large_rv: 32, school_bus: 40, airplane: 50, other: 100}, predicates: true, scope: true
  enumerize :trailer, in: {no_trailer: 0, small_trailer: 10, medium_trailer: 11, large_trailer: 12}, predicates: true, scope: true

  belongs_to :user

  validates :length, numericality: {in: 0..100}, presence: true
  validates :width, numericality: {in: 0..100}, presence: true
  validates :licence_plate, length: {maximum: 20}, allow_blank: true
  validates :vehicle, :trailer, presence: true

  scope :on_map, -> { where(map: true) }
end
