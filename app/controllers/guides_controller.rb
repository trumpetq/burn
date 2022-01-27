class GuidesController < ApplicationController
  before_action :handle_authorization

  # GET /guides
  def show
  end

  # GET /guides/power
  def power
  end

  # GET /guides/shipping_container
  def shipping_container
  end

  private

  def handle_authorization
    authorize(:guide)
  end
end
