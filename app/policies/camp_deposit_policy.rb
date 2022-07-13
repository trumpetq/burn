class CampDepositPolicy < CampPolicy
  def pay?
    me?
  end

  def permitted_attributes
    [:notes, :payment_method, :pricing_tier]
  end
end
