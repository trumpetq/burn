class CampWorkAccessPassPolicy < CampPolicy
  def permitted_attributes
    [:expected_arrival_on, :notes]
  end
end
