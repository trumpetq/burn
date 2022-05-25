module Admin
  class CampApplicationsController < ApplicationController
    include Admin::Campable

    private

    def approve_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).approve.deliver_now if send_email?
      create_camp_interview
    end

    def complete_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).complete.deliver_now if send_email?
      @resource.user.update(plan: :camping_with_us)
      create_camp_interview
    end

    def reject_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(user: @resource.user, resource: @resource).reject.deliver_now if send_email?
      @resource.user.update(plan: :camping_elsewhere)
    end

    def create_camp_interview
      return if @resource.camp_interview.present?

      @resource.camp_interview.create
    end
  end
end
