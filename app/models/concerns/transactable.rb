module Transactable
  extend ActiveSupport::Concern

  included do
    monetize :price_cents

    enumerize :status, in: ::Stepable::STATUSES.slice(:active, :completed, :rejected, :paid), default: :active, predicates: true, scope: true

    enumerize :payment_method, in: {cash: 0, paypal: 1, venmo: 2, other: 10}, default: :cash, predicates: true, scope: true

    enumerize :price_tier, in: {low_income: 1, middle_income: 2, startup: 3, baller: 4}, default: :middle_income, predicates: true, scope: true

    validates :transaction_id, length: {is: 6}
    validates :private_notes, length: {maximum: 10_000}

    before_validation :set_transaction_id
  end

  def set_transaction_id
    return if transaction_id.present?
    self.transaction_id = SecureRandom.hex(3).upcase
  end
end