class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /admin/steps
  def index
    authorize(:step)
    @steps = ::Step.all
  end

  # GET /admin/steps/:id
  def show
  end

  private

  def set_step
    @step = ::Step.find(params[:id])
    authorize([:admin, @step])
  end
end
