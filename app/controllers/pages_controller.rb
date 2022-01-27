class PagesController < ApplicationController
  before_action :handle_authorization

  # GET /
  def home
  end

  # GET /system
  def system
  end

  private

  def handle_authorization
    authorize(:page)
  end
end
