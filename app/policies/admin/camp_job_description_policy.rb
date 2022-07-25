module Admin
  class CampJobDescriptionPolicy < Admin::CampPolicy
    def permitted_attributes
      [:department, :description, :title]
    end
  end
end