module Admin
  class CampsController < ApplicationController
    # GET /camp
    def show
      authorize([:admin, :camp])

      @users_count = ::User.all.count

      @camp_applications_count = ::CampApplication.all.count
      @camp_deposits_count = ::CampDeposit.all.count
      @camp_dues_count = ::CampDue.all.count
      @camp_interviews_count = ::CampInterview.all.count
      @camp_tickets_count = ::CampTicket.all.count
      @camp_vehicles_count = ::CampVehicle.all.count

      @newsletter_count = ::Newsletter.all.count
      @subscribed_count = ::Newsletter.subscribed.count
      @unsubscribed_count = ::Newsletter.unsubscribed.count
      @general_list_count = ::Newsletter.with_list(:general).count
      @campers_only_list_count = ::Newsletter.with_list(:campers_only).count
    end
  end
end
