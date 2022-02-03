class UserStepsController < ApplicationController
  before_action :set_user_step, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_steps
  def index
    authorize(:user_step)
    @user_steps = current_user.user_steps.all
  end

  # GET /admin/user_steps/:id
  def show
  end

  # GET /admin/user_steps/:id/edit
  def edit
  end

  # PATCH /admin/user_steps/:id
  def update
    @user_step.applied_at = Time.current
    @user_step.status = :completed
    if @user_step.update(permitted_attributes(@user_step))
      redirect_to user_step_url(@user_step), success: "Step was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_step
    @user_step = ::UserStep.find(params[:id])
    authorize([:admin, @user_step])
  end
end
