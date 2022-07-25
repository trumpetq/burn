class PagesController < ApplicationController
  before_action :handle_authorization

  # GET /contact
  def contact
  end

  # GET /
  def home
    redirect_to(current_user) if current_user.present?
  end

  private

  def handle_authorization
    authorize(:page)
  end
end
