module Admin
  class CampApplicationsController < ApplicationController
    include Admin::Campable

    def approve_after_save
      CampApplicationMailer.with(user: @resource.user).approve_email.deliver_now if send_email
    end

    def complete_after_save
      CampApplicationMailer.with(user: @resource.user).complete_email.deliver_now if send_email
    end

    def reject_after_save
      CampApplicationMailer.with(user: @resource.user).reject_email.deliver_now if send_email
    end
  end
end
