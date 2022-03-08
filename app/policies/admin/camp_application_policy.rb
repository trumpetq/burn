module Admin
  class CampApplicationPolicy < Admin::CampPolicy
    def permitted_attributes
      [:user_id, :arrival_on, :burning_man_year_count, :covid_protocol, :departure_on, :food_allergies, :plan_to_contribute, :referral_name, :status, :vaccine_status, :what_excites_you, :who_are_you]
    end
  end
end
