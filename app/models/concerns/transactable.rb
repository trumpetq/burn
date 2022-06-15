module Transactable
  extend ActiveSupport::Concern

  included do
    monetize :price_cents

    enumerize :status, in: ::Stepable::STATUSES.slice(:unavailable, :active, :completed, :paid, :refunded, :rejected, :skipped), default: :active, predicates: true, scope: true

    enumerize :payment_method, in: {cash: 0, paypal: 1, venmo: 2, other: 10}, default: :cash, predicates: true, scope: true

    enumerize :pricing_tier, in: {low_income: 10, middle_income: 20, startup: 30, baller: 40}, default: :middle_income, predicates: true, scope: true

    validates :transaction_id, length: {is: 6}
    validates :private_notes, length: {maximum: 10_000}
    validates :pricing_tier, presence: true

    before_validation :set_transaction_id
    before_validation :set_price
  end

  def set_transaction_id
    return if transaction_id.present?
    self.transaction_id = SecureRandom.hex(3).upcase
  end

  def set_price
    return if pricing_tier.blank?
    self.price = Settings.pricing_tiers[pricing_tier].price
  end
end
