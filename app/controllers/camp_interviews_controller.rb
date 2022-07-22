class CampInterviewsController < ApplicationController
  include Campable

  # GET /camp_interviews
  def index
    authorize(:camp_interview)
    @assigned_camp_interviews_pagy, @assigned_camp_interviews = pagy(current_user.camp_interviews.with_status(:assigned).includes([:user, :assigned_by]))
    @finished_camp_interviews_pagy, @finished_camp_interviews = pagy(current_user.camp_interviews.with_status(:approved, :completed, :no_response, :rejected).includes([:user, :assigned_by, :interviewed_by]))
  end

  # PATCH /camp_interviews/:id/approve_or_reject
  def approve_or_reject
    set_resource

    @resource.assign_attributes(permitted_attributes(@resource))

    case params.dig(:camp_interview, :action)&.to_sym
    when :approved then approve
    when :rejected then reject
    when :no_response then no_response
    else
      no_action
    end

    render(
      turbo_stream: turbo_stream.replace(
        "approve_or_reject_card_#{@resource.index}",
        partial: "camp_interviews/approve_or_reject_card",
        locals: {index: @resource.index, camp_interview: @resource}
      )
    )
  end

  private

  def approve
    @resource.status = :approved
    @resource.approved_by = current_user
    @resource.approved_at = Time.current

    if @resource.save && @resource.user.present?
      CampInterviewMailer.with(resource: @resource).approve.deliver_now
      CampInterviewMailer.with(resource: @resource).admin_approve.deliver_now
      @resource.user.update(plan: :camping_with_us)
    end
  end

  def reject
    @resource.status = :rejected
    @resource.rejected_by = current_user
    @resource.rejected_at = Time.current

    if @resource.save && @resource.user.present?
      CampInterviewMailer.with(resource: @resource).reject.deliver_now
      CampInterviewMailer.with(resource: @resource).admin_reject.deliver_now
      @resource.user.update(plan: :camping_elsewhere)
    end
  end

  def no_response
    previous_status = @resource.status.to_sym
    @resource.status = :no_response
    @resource.no_response_by = current_user
    @resource.no_response_at = Time.current

    if @resource.save && @resource.user.present? && previous_status != :no_response
      CampInterviewMailer.with(resource: @resource).no_response.deliver_now
    end
  end

  def no_action
    @resource.errors.add(:action, "is required")
  end
end
