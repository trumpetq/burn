module Admin
  class UserStepsController < ApplicationController
    before_action :set_user_step, only: [:show, :edit, :update, :destroy, :move_higher, :move_lower]

    # GET /admin/user_steps
    def index
      authorize([:admin, :user_step])
      @user_steps = ::UserStep.order(updated_at: :desc)
    end

    # GET /admin/user_steps/:id
    def show
    end

    # GET /admin/user_steps/new
    def new
      @user_step = ::UserStep.new
      authorize([:admin, @user_step])
    end

    # POST /admin/user_steps
    def create
      @user_step = ::UserStep.new(permitted_attributes([:admin, ::UserStep]))
      authorize([:admin, @user_step])
      if @user_step.save
        redirect_to admin_user_step_url(@user_step), success: "User step was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/user_steps/:id/edit
    def edit
    end

    # PATCH /admin/user_steps/:id
    def update
      if @user_step.update(permitted_attributes([:admin, @user_step]))
        redirect_to admin_user_step_url(@user_step), success: "User step was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/user_steps/:id
    def destroy
      @user_step.destroy

      redirect_to admin_user_steps_url, notice: "User step was successfully destroyed."
    end

    # PATCH /admin/user_steps/:id/move_higher
    def move_higher
      @user_step.move_higher
      redirect_to admin_user_steps_url
    end

    # PATCH /admin/user_steps/:id/move_lower
    def move_lower
      @user_step.move_lower
      redirect_to admin_user_steps_url
    end

    private

    def set_user_step
      @user_step = ::UserStep.find(params[:id])
      authorize([:admin, @user_step])
    end
  end
end