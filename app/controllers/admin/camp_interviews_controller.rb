module Admin
  class CampInterviewsController < ApplicationController
    include Admin::Campable

    def assign
      set_resource

      @interviewed_by = ::User.where(id: params.dig(:camp_interview, :interviewed_by_id)).take
      @resource.assigned_at = Time.current
      @resource.assigned_by = current_user
      @resource.interviewed_by = @interviewed_by
      @resource.status = :assigned

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      if @resource.save
        CampInterviewMailer.with(user: @resource.user, interviewed_by: @interviewed_by, resource: @resource).assign.deliver_now if send_email?
        CampInterviewMailer.with(user: @resource.user, interviewed_by: @interviewed_by, resource: @resource).new_interview.deliver_now if send_email?

        redirect_to([:admin, @resource], success: "#{controller_name.humanize} has been assigned to #{@interviewed_by}.", status: :see_other)
      else
        redirect_on_error
      end
    end

    def approve_after_save
      return unless @resource.user.present?

      CampInterviewMailer.with(user: @resource.user, resource: @resource).approve.deliver_now if send_email?
      @resource.user.update(plan: :camping_with_us)
    end

    def complete_after_save
      return unless @resource.user.present?

      @resource.user.update(plan: :camping_with_us)
    end

    def reject_after_save
      return unless @resource.user.present?

      CampInterviewMailer.with(user: @resource.user, resource: @resource).reject.deliver_now if send_email?
      @resource.user.update(plan: :camping_elsewhere)
    end
  end
end
