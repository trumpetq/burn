module Admin
  class CampJobDescriptionPolicy < Admin::CampPolicy
    def permitted_attributes
      [:description, :title]
    end
  end
end