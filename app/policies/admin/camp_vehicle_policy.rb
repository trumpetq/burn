module Admin
  class CampVehiclePolicy < Admin::CampPolicy
    def permitted_attributes
      [:licence_plate, :notes, :ownership, :private_notes, :sleeping, :status, :vehivle_type, :user_id]
    end
  end
end
