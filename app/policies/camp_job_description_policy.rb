class CampJobDescriptionPolicy < CampPolicy
  def permitted_attributes
    [:description, :title, :notes]
  end
end
