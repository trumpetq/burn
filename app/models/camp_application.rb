# == Schema Information
#
# Table name: camp_applications
#
#  id                     :bigint           not null, primary key
#  applied_at             :datetime
#  arrival_on             :date
#  burning_man_year_count :integer
#  completed_at           :datetime
#  covid_protocol         :text
#  departure_on           :date
#  food_allergies         :text
#  plan_to_contribute     :text
#  referral_name          :string
#  status                 :integer          default("unavailable"), not null
#  vaccine_status         :integer
#  what_excites_you       :text
#  who_are_you            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint
#
# Indexes
#
#  index_camp_applications_on_user_id  (user_id)
#
class CampApplication < ApplicationRecord
  include Stepable
  extend Enumerize

  enumerize :status, in: {unavailable: 0, active: 1, closed: 10, completed: 20}, default: :active, predicates: true, scope: true

  enumerize :vaccine_status, in: {unvaccinated: 0, vaccinated: 1, vaccinated_and_bosted: 2}, predicates: true, scope: true

  validates :plan_to_contribute, :what_excites_you, :who_are_you, :vaccine_status, :burning_man_year_count, :arrival_on, :departure_on, presence: true

  validates :burning_man_year_count, numericality: {only_integer: true, in: 0..(Settings.date.current_year - 1986)}
end
