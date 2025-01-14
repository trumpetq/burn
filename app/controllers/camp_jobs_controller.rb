class CampJobsController < ApplicationController
  include Campable
  before_action :locked, only: [:edit, :update, :remove, :sign_up]

  # PATCH /camp_jobs/:id/remove
  def remove
    set_resource

    @resource.update(status: :active, user: nil, assigned_by: nil)

    redirect_to(camp_jobs_url, notice: "You have been removed from this job. Don't forget to sign up for something else.", status: :see_other)
  end

  # PATCH /camp_jobs/:id/sign_up
  def sign_up
    set_resource

    status = @resource.active? ? :assigned : resource.status
    @resource.update(user: current_user, assigned_by: current_user, status: status)

    flash.now[:notice] = "Thank you for helping build camp."
    render :show, status: :unprocessable_entity
  end

  private

  def search_index
    @query = @query.for_user(current_user).includes(:camp_job_description).order_by_date
  end

  def after_index
    @camp_job_query = ::CampJob.includes(:camp_job_description, :user).order_by_title
    @camp_job_query = @camp_job_query.with_status(params[:search][:status]) if params.dig(:search, :status).present?
    @camp_job_query = @camp_job_query.in_bay_area if params.dig(:search, :bay_area) == "1"

    timeframe = params.dig(:search, :timeframe).presence
    if timeframe
      instance_variable_set("@#{timeframe}_camp_jobs".to_sym, @camp_job_query.with_timeframe(timeframe))
    else
      set_all_camp_jobs
    end
  end

  def after_new
    @resource.availability = params[:availability] if params[:availability].present?
  end

  def set_all_camp_jobs
    @pre_event_camp_jobs = @camp_job_query.with_timeframe(:pre_event)
    @build_week_camp_jobs = @camp_job_query.with_timeframe(:build_week)

    @sunday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-08-28")
    @monday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-08-29")
    @tuesday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-08-30")
    @wednesday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-08-31")
    @thursday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-09-01")
    @friday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-09-02")
    @saturday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-09-03")
    @saturday_camp_jobs = @camp_job_query.with_timeframe(:burn_week).on_day("2022-09-03")

    day_job_ids = [@sunday_camp_jobs.map(&:id), @monday_camp_jobs.map(&:id), @tuesday_camp_jobs.map(&:id), @wednesday_camp_jobs.map(&:id), @thursday_camp_jobs.map(&:id), @friday_camp_jobs.map(&:id), @saturday_camp_jobs.map(&:id), @sunday_camp_jobs.map(&:id)].flatten
    @other_burn_week_camp_jobs = @camp_job_query.with_timeframe(:burn_week).where.not(id: day_job_ids)

    @strike_camp_jobs = @camp_job_query.with_timeframe(:strike)

    @post_event_camp_jobs = @camp_job_query.with_timeframe(:post_event)

    @year_round_camp_jobs = @camp_job_query.with_timeframe(:year_round)
  end
end
