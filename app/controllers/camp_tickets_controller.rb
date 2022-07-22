class CampTicketsController < ApplicationController
  include Campable

  # GET /camp_tickets
  def index
    authorize(:camp_ticket)
    @query = ::CampTicket.for_user(current_user)

    @pagy, @camp_tickets = pagy(@query.includes(:user).order(updated_at: :desc))
  end

  private

  def after_new
    @resource.availability = params[:availability] if params[:availability].present?
  end
end
