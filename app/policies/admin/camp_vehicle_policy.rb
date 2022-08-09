module Admin
  class CampVehiclePolicy < Admin::CampPolicy
    def permitted_attributes
      [:licence_plate, :notes, :private_notes, :sleeping, :status, :trailer, :vehicle, :length, :width, :map, :user_id]
    end
  end
end
