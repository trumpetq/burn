class CampDuesController < ApplicationController
  include Campable

  def after_create
    @redirect_url = camp_due_url(@resource)
  end

  def after_new
    redirect_to(camp_due_url(current_user.camp_due), notice: "It looks like you already started paying dues. Here is your current information.") if current_user&.camp_due.present?
  end
end
