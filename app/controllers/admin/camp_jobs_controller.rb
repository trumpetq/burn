module Admin
  class CampJobsController < ApplicationController
    include Admin::Campable

    # GET /admin/camp_jobs/print_all
    def print_all
      authorize([:admin, :camp_job])
      set_all_camp_jobs
      render layout: "print"
    end

    private

    def search_index
      @query = @query.includes(:camp_job_description)
    end

    def active_after_save
      @resource.update(user: nil)
    end

    def set_all_camp_jobs
      @camp_job_query = ::CampJob.includes(:camp_job_description, :user).order_by_title

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
end