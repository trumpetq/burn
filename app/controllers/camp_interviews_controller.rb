class CampInterviewsController < ApplicationController
  include Campable

  # GET /camp_interviews
  def index
    authorize(:camp_interview)
    @assigned_camp_interviews = current_user.assigned_camp_interviews
    @pagy, @completed_camp_interviews = pagy(current_user.assigned_camp_interviews)

  end
end
