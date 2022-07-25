class CampApplicationPolicy < CampPolicy
  def show?
    (member? && me?) || camper?
  end

  def should_apply?
    new? && user.camp_application.blank? && user.might_camp_with_us?
  end

  def start?
    everyone?
  end

  def permitted_attributes
    [:arrival_on, :burning_man_year_count, :covid_protocol, :departure_on, :food_allergies, :plan_to_contribute, :referral_name, :vaccine_status, :what_excites_you, :who_are_you]
  end
end
