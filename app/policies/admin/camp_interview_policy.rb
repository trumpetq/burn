module Admin
  class CampInterviewPolicy < Admin::CampPolicy
    def permitted_attributes
      [:user_id, :status, :feedback_notes, :initial_notes, :private_notes]
    end
  end
end
