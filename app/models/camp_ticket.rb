# == Schema Information
#
# Table name: camp_tickets
#
#  id              :bigint           not null, primary key
#  availability    :integer          not null
#  location        :integer          not null
#  notes           :text
#  private_notes   :text
#  sale            :integer          not null
#  status          :integer          not null
#  ticket_type     :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  confirmation_id :string
#  user_id         :bigint           not null
#
# Indexes
#
#  index_camp_tickets_on_user_id  (user_id)
#
class CampTicket < ApplicationRecord
  extend Enumerize

  include Stepable

  enumerize :status, in: STATUSES.slice(:active), default: :active, predicates: true, scope: true

  enumerize :availability, in: {using_myself: 0, for_a_friend: 1, for_sale: 2, wanted: 3}, default: :using_myself, predicates: true, scope: true

  enumerize :location, in: {physical_ticket: 0, will_call: 1}, default: :physical_ticket, predicates: true, scope: true

  enumerize :ticket_type, in: {ticket: 0, vehicle_pass: 1}, default: :ticket, predicates: true, scope: true

  enumerize :sale, in: {main: 0, fomo: 1, steward: 2, ticket_aid_program: 3, step: 4, kid_ticket: 5, omg: 6, invitation_to_the_future: 7, staff: 8, art_project: 9, other: 10}, default: :main, predicates: true, scope: true

  validates :confirmation_id, length: {maximum: 100}
  validates :notes, length: {maximum: 10_000}

  scope :owned, -> { with_availability(:using_myself, :for_a_friend, :for_sale) }
  scope :wanted, ->{ with_availability(:wanted) }

  def multiple?
    true
  end

  def finished?
    false
  end
end
