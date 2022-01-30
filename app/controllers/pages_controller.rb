class PagesController < ApplicationController
  before_action :handle_authorization

  # GET /contact
  def contact
  end

  # GET /
  def home
  end

  private

  def handle_authorization
    authorize(:page)
  end
end
