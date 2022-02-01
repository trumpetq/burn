class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?

  add_flash_types :success, :warning

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :play_name])
  end

  private

  def user_not_authorized(e)
    raise e if Rails.env.development?

    flash.now[:alert] = "Sorry, you don't have permission for that!"
    render "errors/forbidden", status: :forbidden
  end
end
