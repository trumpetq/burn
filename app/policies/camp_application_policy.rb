class CampApplicationPolicy < CampPolicy
  def admin?
    leader?
  end

  def permitted_attributes
    [:arrival_on, :burning_man_year_count, :covid_protocol, :departure_on, :food_allergies, :plan_to_contribute, :referral_name, :vaccine_status, :what_excites_you, :who_are_you]
  end
end
