class ErrorsController < ApplicationController
  before_action :handle_authorization

  def forbidden
    render status: :forbidden
  end

  def internal_server_error
    render status: :internal_server_error
  end

  def not_acceptable
    render status: :not_acceptable
  end

  def not_found
    render status: :not_found
  end

  def unauthorized
    render status: :unauthorized
  end

  def unprocessable_entity
    render status: :unprocessable_entity
  end

  private

  def handle_authorization
    authorize(:error)
  end
end
