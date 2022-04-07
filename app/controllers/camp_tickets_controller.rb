class CampTicketsController < ApplicationController
  include Campable

  # GET /camp_tickets
  def index
    authorize(:camp_ticket)
    query = ::CampTicket.for_user(current_user)

    @camp_tickets = query.includes(:user).order(updated_at: :desc)
  end

  private

  def after_new
    @resource.availability = params[:availability] if params[:availability].present?
  end
end
