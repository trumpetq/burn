module Admin
  class CampJobDefinitionPolicy < Admin::CampPolicy
    def permitted_attributes
      [:approval_required, :description, :east_bay, :notes, :points, :private_notes, :status, :strong_person, :timeframe, :title, :user_id]
    end
  end
end