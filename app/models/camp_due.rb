# == Schema Information
#
# Table name: camp_dues
#
#  id              :bigint           not null, primary key
#  completed_at    :datetime
#  notes           :text
#  paid_at         :datetime
#  payment_method  :integer
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("USD"), not null
#  pricing_tier    :integer
#  private_notes   :text
#  refunded_at     :datetime
#  rejected_at     :datetime
#  skipped_at      :datetime
#  status          :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  completed_by_id :bigint
#  paid_by_id      :bigint
#  refunded_by_id  :bigint
#  rejected_by_id  :bigint
#  skipped_by_id   :bigint
#  transaction_id  :string           not null
#  user_id         :bigint
#
# Indexes
#
#  index_camp_dues_on_user_id  (user_id)
#
class CampDue < ApplicationRecord
  extend Enumerize

  include Stepable
  include Transactable

  enumerize :status, in: STATUSES.slice(:active, :completed, :paid, :refunded, :rejected, :skipped), default: :active, predicates: true, scope: true

  belongs_to :user

  def finished?
    completed? || paid? || skipped?
  end
end
