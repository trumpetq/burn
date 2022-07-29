class CampJobsController < ApplicationController
  include Campable

  private

  def search_index
    @query = @query.for_user(current_user)
  end

  def after_index
    @camp_job_definition_query = ::CampJobDefinition.order_by_date
    @camp_job_definition_query = @camp_job_definition_query.with_status(params[:search][:status]) if params.dig(:search, :status).present?
    @camp_job_definition_query = @camp_job_definition_query.in_bay_area if params.dig(:search, :bay_area) == "1"



    timeframe = params.dig(:search, :timeframe).presence
    if timeframe
      instance_variable_set("@#{timeframe}_camp_job_definitions".to_sym, @camp_job_definition_query.with_timeframe(timeframe))
    else
      set_all_camp_job_definitions
    end
  end

  def after_new
    @resource.availability = params[:availability] if params[:availability].present?
  end

  def set_all_camp_job_definitions
    @pre_event_camp_job_definitions = @camp_job_definition_query.with_timeframe(:pre_event)

    @build_week_camp_job_definitions = @camp_job_definition_query.with_timeframe(:build_week)

    @burn_week_camp_job_definitions = @camp_job_definition_query.with_timeframe(:burn_week)

    @strike_camp_job_definitions = @camp_job_definition_query.with_timeframe(:strike)

    @post_event_camp_job_definitions = @camp_job_definition_query.with_timeframe(:post_event)

    @year_round_camp_job_definitions = @camp_job_definition_query.with_timeframe(:year_round)
  end
end
