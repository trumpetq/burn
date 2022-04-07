module Admin
  class CampDepositPolicy < Admin::CampPolicy
    def permitted_attributes
      [:user_id, :status, :payment_method, :price_tier, :price, :private_notes]
    end
  end
end