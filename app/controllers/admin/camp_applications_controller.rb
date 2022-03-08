module Admin
  class CampApplicationsController < ApplicationController
    include Admin::Campable

    def approve_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user).approve_email.deliver_now if send_email
    end

    def complete_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user).complete_email.deliver_now if send_email
      @resource.user.update(plan: :camping_with_us)
    end

    def reject_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user).reject_email.deliver_now if send_email
      @resource.user.update(plan: :camping_elsewhere)
    end
  end
end
