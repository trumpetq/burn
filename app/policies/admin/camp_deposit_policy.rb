module Admin
  class CampDepositPolicy < Admin::CampPolicy
    def edit?
      mayor?
    end

    def update?
      edit?
    end

    def permitted_attributes
      [:user_id, :status, :payment_method, :pricing_tier, :price, :private_notes]
    end
  end
end