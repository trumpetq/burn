class CampApplicationPolicy < CampPolicy
  def permitted_attributes
    attrs = [:burning_man_year_count]

    attrs
  end
end
