module Admin
  class CampJobPolicy < Admin::CampPolicy
    def permitted_attributes
      [:notes, :private_notes, :status, :user_id]
    end
  end
end