module Transactable
  extend ActiveSupport::Concern

  included do
    monetize :price_cents

    enumerize :status, in: ::Stepable::STATUSES.slice(:unavailable, :active, :completed, :paid, :refunded, :rejected, :skipped), default: :active, predicates: true, scope: true

    enumerize :payment_method, in: {cash: 0, paypal: 1, venmo: 2, other: 10}, default: :cash, predicates: true, scope: true

    enumerize :pricing_tier, in: {low_income: 10, middle_income: 20, startup: 30, baller: 40}, default: :middle_income, predicates: true, scope: true

    before_validation :set_transaction_id
    before_validation :set_price

    validates :transaction_id, length: {is: 6}, uniqueness: true
    validates :private_notes, length: {maximum: 10_000}
    validates :pricing_tier, presence: true

    scope :for_transaction_id, ->(transaction_id) { where(transaction_id: transaction_id&.upcase) }
  end

  def preferred_payment_method?
    payment_method.paypal? || payment_method.venmo?
  end

  def set_transaction_id
    return if transaction_id.present?
    loop do
      self.transaction_id = SecureRandom.hex(3).upcase
      break unless ::CampDue.for_transaction_id(transaction_id).exists? || ::CampDeposit.for_transaction_id(transaction_id).exists?
    end
  end

  def set_price
    return if pricing_tier.blank?
    self.price = Settings.pricing_tiers[pricing_tier].price
  end
end
