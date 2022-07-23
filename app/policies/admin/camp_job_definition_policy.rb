module Admin
  class CampJobDefinitionPolicy < Admin::CampPolicy
    def permitted_attributes
      [:all_day, :approval_required, :begin_at, :camp_job_description_id, :east_bay, :end_at, :job_on, :notes, :points, :private_notes, :status, :strong_person, :timeframe, :user_id]
    end
  end
end