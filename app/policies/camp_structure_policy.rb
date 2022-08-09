class CampStructurePolicy < CampPolicy
  def edit?
    member? && me?
  end

  def permitted_attributes
    [:structure, :length, :width, :description, :notes]
  end
end
