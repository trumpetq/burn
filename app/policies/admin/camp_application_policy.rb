module Admin
  class CampApplicationPolicy < Admin::CampPolicy
    def permitted_attributes
      attrs = [:applied_at, :arrival_on, :burning_man_year_count, :completed_at, :covid_protocol, :departure_on, :food_allergies, :plan_to_contribute, :referral_name, :status, :vaccine_status, :what_excites_you, :who_are_you]
      attrs += [:user_id] if user.mayor?
      attrs
    end
  end
end
