class CampJobPolicy < CampPolicy
  def permitted_attributes
    [:notes]
  end
end
