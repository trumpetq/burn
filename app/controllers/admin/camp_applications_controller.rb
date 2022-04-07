module Admin
  class CampApplicationsController < ApplicationController
    include Admin::Campable

    private

    def approve_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).approve.deliver_now if send_email?
    end

    def complete_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).complete.deliver_now if send_email?
      @resource.user.update(plan: :camping_with_us)
    end

    def reject_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).reject.deliver_now if send_email?
      @resource.user.update(plan: :camping_elsewhere)
    end
  end
end
