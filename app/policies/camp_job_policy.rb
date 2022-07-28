class CampJobPolicy < CampPolicy
  def permitted_attributes
    [:camp_job_definition_id, :notes]
  end
end
