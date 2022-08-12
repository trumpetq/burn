module Admin
  class CampsController < ApplicationController
    # GET /camp
    def show
      authorize([:admin, :camp])

      @users_count = ::User.all.count
      @mayor_users_count = ::User.with_role(:mayor).count
      @leader_users_count = ::User.with_role(:leader).count
      @confirmed_users_count = ::User.with_status(:confirmed).count
      @camping_with_us_users_count = ::User.with_plan(:camping_with_us).count
      @thinking_about_it_users_count = ::User.with_plan(:thinking_about_it).count
      @camping_elsewhere_users_count = ::User.with_plan(:camping_elsewhere).count
      @not_going_users_count = ::User.with_plan(:not_going).count
      @no_plan_users_count = ::User.with_plan(:none).count
      @kept_users_count = ::User.kept.count
      @deleted_users_count = ::User.discarded.count


      @camp_applications_count = ::CampApplication.all.count
      @active_camp_applications_count = ::CampApplication.with_status(:active).count
      @approved_camp_applications_count = ::CampApplication.with_status(:approved).count
      @completed_camp_applications_count = ::CampApplication.with_status(:completed).count
      @rejected_camp_applications_count = ::CampApplication.with_status(:rejected).count

      @camp_interviews_count = ::CampInterview.all.count
      @active_camp_interviews_count = ::CampInterview.with_status(:active).count
      @approved_camp_interviews_count = ::CampInterview.with_status(:approved).count
      @assigned_camp_interviews_count = ::CampInterview.with_status(:assigned).count
      @completed_camp_interviews_count = ::CampInterview.with_status(:completed).count
      @no_response_camp_interviews_count = ::CampInterview.with_status(:no_response).count
      @rejected_camp_interviews_count = ::CampInterview.with_status(:rejected).count
      @skipped_camp_interviews_count = ::CampInterview.with_status(:skipped).count

      @camp_dues_count = ::CampDue.all.count
      @active_camp_dues_count = ::CampDue.with_status(:active).count
      @completed_camp_dues_count = ::CampDue.with_status(:completed).count
      @paid_camp_dues_count = ::CampDue.with_status(:paid).count
      @refunded_camp_dues_count = ::CampDue.with_status(:refunded).count
      @rejected_camp_dues_count = ::CampDue.with_status(:rejected).count
      @skipped_camp_dues_count = ::CampDue.with_status(:skipped).count

      @camp_deposits_count = ::CampDeposit.all.count
      @active_camp_deposits_count = ::CampDeposit.with_status(:active).count
      @completed_camp_deposits_count = ::CampDeposit.with_status(:completed).count
      @paid_camp_deposits_count = ::CampDeposit.with_status(:paid).count
      @refunded_camp_deposits_count = ::CampDeposit.with_status(:refunded).count
      @rejected_camp_deposits_count = ::CampDeposit.with_status(:rejected).count
      @skipped_camp_deposits_count = ::CampDeposit.with_status(:skipped).count

      @camp_jobs_count = ::CampJob.all.count
      @active_camp_jobs_count = ::CampJob.with_status(:active).count
      @approved_camp_jobs_count = ::CampJob.with_status(:approved).count
      @assigned_camp_jobs_count = ::CampJob.with_status(:assigned).count
      @completed_camp_jobs_count = ::CampJob.with_status(:completed).count
      @rejected_camp_jobs_count = ::CampJob.with_status(:rejected).count
      @skipped_camp_jobs_count = ::CampJob.with_status(:skipped).count

      @camp_job_descriptions_count = ::CampJobDescription.all.count
      @active_camp_job_descriptions_count = ::CampJobDescription.with_status(:active).count

      @camp_tickets_count = ::CampTicket.all.count
      @active_camp_tickets_count = ::CampTicket.with_status(:active).count
      @owned_ticket_camp_tickets_count = ::CampTicket.owned.with_ticket_type(:ticket).count
      @owned_vehicle_pass_camp_tickets_count = ::CampTicket.owned.with_ticket_type(:vehicle_pass).count
      @wanted_ticket_camp_tickets_count = ::CampTicket.wanted.with_ticket_type(:ticket).count
      @wanted_vehicle_pass_camp_tickets_count = ::CampTicket.wanted.with_ticket_type(:vehicle_pass).count

      @camp_vehicles_count = ::CampVehicle.all.count
      @active_camp_vehicles_count = ::CampVehicle.with_status(:active).count
      @approved_camp_vehicles_count = ::CampVehicle.with_status(:approved).count
      @completed_camp_vehicles_count = ::CampVehicle.with_status(:completed).count
      @rejected_camp_vehicles_count = ::CampVehicle.with_status(:rejected).count

      @camp_work_access_passes_count = ::CampWorkAccessPass.all.count
      @active_camp_work_access_passes_count = ::CampWorkAccessPass.with_status(:active).count
      @assigned_camp_work_access_passes_count = ::CampWorkAccessPass.with_status(:assigned).count
      @approved_camp_work_access_passes_count = ::CampWorkAccessPass.with_status(:approved).count
      @rejected_camp_work_access_passes_count = ::CampWorkAccessPass.with_status(:rejected).count

      @newsletters_count = ::Newsletter.all.count
      @subscribed_newsletters_count = ::Newsletter.subscribed.count
      @unsubscribed_newsletters_count = ::Newsletter.unsubscribed.count
      @general_list_newsletters_count = ::Newsletter.with_list(:general).count
      @campers_only_list_newsletters_count = ::Newsletter.with_list(:campers_only).count
    end
  end
end
