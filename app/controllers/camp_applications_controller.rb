class CampApplicationsController < ApplicationController
  include Campable

  def after_new
    redirect_to(current_user.camp_application, notice: "It looks like you already applied. Here is your current application.") if current_user&.camp_application.present?
  end

  def after_create
    CampApplicationMailer.with(resource: @resource).admin_apply.deliver_now
  end
end
