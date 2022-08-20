class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from StandardError, with: :internal_server_error # Must go first!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?

  add_flash_types :success, :warning

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :play_name])
  end

  def locked
    return unless Settings.camp.locked
    render "errors/locked", status: :forbidden
  end

  private

  def internal_server_error(e)
    raise e if Rails.env.development?

    Rollbar.error(e)
    @error = e
    render "errors/internal_server_error", status: :internal_server_error
  end

  def not_found(e)
    Rollbar.error(e)
    @error = e
    render "errors/not_found", status: :not_found
  end

  def user_not_authorized(e)
    @error = e

    if current_user.present?
      Rollbar.error(e)
      flash.now[:alert] = "Sorry, you don't have permission for that!"
      render "errors/forbidden", status: :forbidden
    else
      redirect_to(new_user_session_url, alert: "You need to be signed in first.")
    end
  end
end
