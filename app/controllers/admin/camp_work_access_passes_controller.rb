module Admin
  class CampWorkAccessPassesController < ApplicationController
    include Admin::Campable

    # GET /admin/camp_jobs/print_all
    def print_all
      authorize([:admin, :camp_job])
      @resources = ::CampWorkAccessPass.includes(:user).order(pass_on: :asc)
      render layout: "print"
    end

    # PATCH /admin/camp_work_access_passes/:id/remove_ticket
    def remove_ticket
      set_resource
      @resource.update(ticket: nil)

      redirect_to(admin_camp_work_access_pass_url(@resource), notice: "PDF has been removed.", status: :see_other)
    end

    private

    def search_index
      @query = @query.includes(:ticket_attachment).reorder_by_date
    end

    private

    def active_after_save
      @resource.update!(user: nil, expected_arrival_on: nil)
    end

    def approve_after_save
      return unless @resource.user.present?

      CampWorkAccessPassMailer.with(resource: @resource).approve.deliver_now if send_email?
    end

    def assign_after_save
      return unless @resource.user.present?

      CampWorkAccessPassMailer.with(resource: @resource).assign.deliver_now if send_email?
    end

    def reject_after_save
      @resource.update(user: nil)
    end
  end
end
