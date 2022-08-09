module Admin
  class CampStructurePolicy < Admin::CampPolicy
    def permitted_attributes
      [:description, :notes, :private_notes, :structure, :map, :length, :width, :user_id]
    end
  end
end
