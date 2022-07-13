class CampDuesController < ApplicationController
  include Campable

  def after_new
    redirect_to camp_due_url(current_user.camp_due) if current_user.camp_due.present?
  end
end
