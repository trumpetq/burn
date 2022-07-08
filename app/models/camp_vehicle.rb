# == Schema Information
#
# Table name: camp_vehicles
#
#  id              :bigint           not null, primary key
#  approved_at     :datetime
#  completed_at    :datetime
#  licence_plate   :string
#  notes           :text
#  ownership       :integer
#  private_notes   :text
#  rejected_at     :datetime
#  sleeping        :boolean
#  status          :integer          not null
#  vehicle_type    :integer
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
end
