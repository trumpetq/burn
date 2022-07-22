class CampJobsController < ApplicationController
  include Campable

  # GET /camp_jobs
  def index
    authorize(:camp_job)
    @query = ::CampJob.for_user(current_user)

    @pagy, @camp_jobs = pagy(@query.includes(:user).order(updated_at: :desc))
  end

  private

  def after_new
    @resource.availability = params[:availability] if params[:availability].present?
  end
end
