module Admin
  class CampJobPolicy < Admin::CampPolicy
    def permitted_attributes
      [:camp_job_definition_id, :notes, :private_notes, :status, :user_id]
    end
  end
end