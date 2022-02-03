module Admin
  class StepsController < ApplicationController
    before_action :set_step, only: [:show, :edit, :update, :destroy, :move_higher, :move_lower]

    # GET /admin/steps
    def index
      authorize(:step)
      @steps = ::Step.all.order(position: :asc)
    end

    # GET /admin/steps/:id
    def show
    end

    # GET /admin/steps/new
    def new
      @step = ::Step.new
      authorize([:admin, @step])
    end

    # POST /admin/steps
    def create
      @step = ::Step.new(permitted_attributes([:admin, ::Step]))
      authorize([:admin, @step])

      if @step.save
        redirect_to admin_step_url(@step), success: "Step was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/steps/:id/edit
    def edit
    end

    # PATCH /admin/steps/:id
    def update
      if @step.update(permitted_attributes([:admin, @step]))
        redirect_to admin_step_url(@step), success: "Step was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/steps/:id
    def destroy
      @step.destroy

      redirect_to admin_steps_url, notice: "Step was successfully destroyed."
    end

    # PATCH /admin/steps/:id/move_higher
    def move_higher
      @step.move_higher
      redirect_to admin_steps_url
    end

    # PATCH /admin/steps/:id/move_lower
    def move_lower
      @step.move_lower
      redirect_to admin_steps_url
    end

    private

    def set_step
      @step = ::Step.find(params[:id])
      authorize([:admin, @step])
    end
  end
end