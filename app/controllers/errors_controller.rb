class ErrorsController < ApplicationController
  before_action :handle_authorization

  # GET /403
  def forbidden
    render status: :forbidden
  end

  # GET /500
  def internal_server_error
    render status: :internal_server_error
  end

  # GET /406
  def not_acceptable
    render status: :not_acceptable
  end

  # GET /404
  def not_found
    render status: :not_found
  end

  # GET /401
  def unauthorized
    render status: :unauthorized
  end

  # GET /422
  def unprocessable_entity
    render status: :unprocessable_entity
  end

  private

  def handle_authorization
    authorize(:error)
  end
end
