# == Schema Information
#
# Table name: camp_applications
#
#  id                     :bigint           not null, primary key
#  applied_at             :datetime
#  approved_at            :datetime
#  arrival_on             :date
#  burning_man_year_count :integer
#  completed_at           :datetime
#  covid_protocol         :text
#  departure_on           :date
#  discarded_at           :datetime
#  food_allergies         :text
#  plan_to_contribute     :text
#  referral_name          :string
#  rejected_at            :datetime
#  status                 :integer          not null
#  vaccine_status         :integer
#  what_excites_you       :text
#  who_are_you            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  approved_by_id         :bigint
#  completed_by_id        :bigint
#  rejected_by_id         :bigint
#  user_id                :bigint
#
# Indexes
#
#  index_camp_applications_on_discarded_at  (discarded_at)
#  index_camp_applications_on_user_id       (user_id)
#
class CampApplication < ApplicationRecord
  extend Enumerize

  include Stepable
  include Discard::Model

  enumerize :status, in: STATUSES.slice(:active, :approved, :completed, :rejected), default: :active, predicates: true, scope: true
  enumerize :vaccine_status, in: {unvaccinated: 0, vaccinated: 1, vaccinated_and_boosted: 2}, predicates: true, scope: true

  validates :plan_to_contribute, :what_excites_you, :who_are_you, :vaccine_status, :burning_man_year_count, :arrival_on, :departure_on, presence: true
  validates :burning_man_year_count, numericality: {only_integer: true, in: 0..(Settings.date.current_year - 1986)}
  validates :covid_protocol, :food_allergies, :plan_to_contribute, :who_are_you, :what_excites_you, length: {maximum: 10_000}
  validates :referral_name, length: {maximum: 250}

  def finished?
    completed? || approved?
  end
end
