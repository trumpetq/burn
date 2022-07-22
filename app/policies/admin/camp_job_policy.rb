module Admin
  class CampJobPolicy < Admin::CampPolicy
    def permitted_attributes
      [:begin_at, :end_at, :job_on, :notes, :private_notes, :status, :user_id]
    end
  end
end