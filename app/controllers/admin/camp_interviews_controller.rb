module Admin
  class CampInterviewsController < ApplicationController
    include Admin::Campable

    # GET /admin/camp_interviews
    def index
      authorize([:admin, :camp_interview])
      @pagy, @resources = pagy(::CampInterview.includes(:user, :interviewed_by).order(updated_at: :desc))
    end

    # PATCH /admin/camp_interviews/:id/assign
    def assign
      set_resource

      @interviewed_by = ::User.where(id: params.dig(:camp_interview, :interviewed_by_id)).take
      @resource.assigned_at = Time.current
      @resource.assigned_by = current_user
      @resource.interviewed_by = @interviewed_by
      @resource.status = :assigned

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      if @resource.save
        CampInterviewMailer.with(resource: @resource).assign.deliver_now if send_email?
        CampInterviewMailer.with(resource: @resource).new_interview.deliver_now if send_email?

        redirect_to([:admin, @resource], success: "#{controller_name.singularize.humanize} has been assigned to #{@interviewed_by}.", status: :see_other)
      else
        redirect_on_error
      end
    end

    private

    def approve_after_save
      return unless @resource.user.present?

      CampInterviewMailer.with(resource: @resource).approve.deliver_now if send_email?
      @resource.user.update(plan: :camping_with_us)
    end

    def complete_after_save
      return unless @resource.user.present?

      @resource.user.update(plan: :camping_with_us)
    end

    def reject_after_save
      return unless @resource.user.present?

      CampInterviewMailer.with(resource: @resource).reject.deliver_now if send_email?
      @resource.user.update(plan: :camping_elsewhere)
    end
  end
end
