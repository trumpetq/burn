class CampWorkAccessPassesController < ApplicationController
  include Campable
  before_action :locked, only: [:edit, :update, :sign_up, :remove]

  # GET /camp_jobs
  def index
    authorize(:camp_work_access_pass)

    @query = ::CampWorkAccessPass.includes(:user).order(pass_on: :asc)

    @pagy, @resources = pagy(@query)

    @camp_work_access_pass = current_user.camp_work_access_pass
  end

  # PATCH /camp_jobs/:id/sign_up
  def sign_up
    set_resource

    @resource.status = :assigned if @resource.active?
    @resource.user = current_user
    @resource.assigned_by = current_user

    @resource.assign_attributes(permitted_attributes(@resource))

    if @resource.save
      redirect_to(camp_work_access_pass_url(@resource))
    else
      render(
        turbo_stream: turbo_stream.replace(
          "camp_work_access_pass_sign_up_card",
          partial: "camp_work_access_passes/sign_up_card",
          locals: {resource: @resource}
        )
      )
    end
  end
end
