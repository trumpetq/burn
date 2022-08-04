class CampWorkAccessPassesController < ApplicationController
  include Campable

  # GET /camp_jobs
  def index
    authorize(:camp_work_access_pass)

    @query = ::CampWorkAccessPass.includes(:user).order(pass_on: :asc)

    @pagy, @resources = pagy(@query)
  end

  # PATCH /camp_jobs/:id/sign_up
  def sign_up
    set_resource

    @resource.status = :assigned if @resource.active?
    @resource.user = current_user
    @resource.assigned_by = current_user

    if @resource.save
      flash.now[:notice] = "Thank you for helping build camp."
      render :show
    else
      render :show, status: :unprocessable_entity
    end
  end
end
