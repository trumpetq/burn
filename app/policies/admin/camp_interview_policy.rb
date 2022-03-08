module Admin
  class CampInterviewPolicy < Admin::CampPolicy
    def assign?
      mayor?
    end

    def permitted_attributes
      [:user_id, :status, :feedback_notes, :initial_notes, :private_notes]
    end
  end
end
