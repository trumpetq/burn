module Admin
  class CampApplicationsController < ApplicationController
    include Admin::Campable

    private

    def approve_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(resource: @resource).approve.deliver_now if send_email?
      create_camp_interview
    end

    def complete_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(resource: @resource).complete.deliver_now if send_email?
      @resource.user.update(plan: :camping_with_us)
      create_camp_interview
    end

    def reject_after_save
      return unless @resource.user.present?

      CampApplicationMailer.with(resource: @resource).reject.deliver_now if send_email?
      @resource.user.update(plan: :camping_elsewhere)
    end

    def create_camp_interview
      return if @resource.user&.camp_interview.present?

      @resource.user.create_camp_interview
    end
  end
end
