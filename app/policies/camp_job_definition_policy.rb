class CampJobDefinitionPolicy < CampPolicy
  def permitted_attributes
    [:points, :timeframe, :job_on, :all_day, :approval_required, :bay_area, :financial, :strong_person]
  end
end
