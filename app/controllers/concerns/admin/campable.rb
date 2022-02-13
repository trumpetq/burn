module Admin
  module Campable
    extend ActiveSupport::Concern

    included do
      before_action :set_resource, only: [:show, :edit, :update, :destroy, :approve, :complete, :restore, :reject]
    end

    # GET /admin/resources
    def index
      authorize([:admin, controller_name.classify.underscore.to_sym])
      @pagy, @resources = pagy(controller_name.classify.constantize.order(updated_at: :desc))
    end

    # GET /admin/resources/:id
    def show
    end

    # GET /admin/resources/new
    def new
      @resource = controller_name.classify.constantize.new
      authorize([:admin, @resource])
    end

    # POST /admin/resources
    def create
      @resource = controller_name.classify.constantize.new(permitted_attributes([:admin, controller_name.classify.constantize]))
      authorize([:admin, @resource])
      if @resource.save
        redirect_to [:admin, @resource], success: "#{controller_name.humanize} was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/resources/:id/edit
    def edit
    end

    # PATCH /admin/resources/:id
    def update
      if @resource.update(permitted_attributes([:admin, @resource]))
        redirect_to [:admin, @resource], success: "#{controller_name.humanize} was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/resources/:id
    def destroy
      @resource.discard

      redirect_to admin_root_path, notice: "#{controller_name.humanize} was successfully destroyed.", status: :see_other
    end

    # POST /admin/resources/:id/approve
    def approve
      @resource.approved_at = Time.current
      @resource.approved_by = current_user
      @resource.status = :approved

      @resource.save!
      if @resource.save
        redirect_to([:admin, @resource], notice: "#{controller_name.humanize} has been approved.")
      else
        redirect_on_error
      end
    end

    # POST /admin/resources/:id/complete
    def complete
      @resource.completed_at = Time.current
      @resource.completed_by = current_user
      @resource.status = :completed

      if @resource.save
        redirect_to([:admin, @resource], notice: "#{controller_name.humanize} has been approved.")
      else
        redirect_on_error
      end
    end

    # POST /admin/resources/:id/reject
    def reject
      @resource.rejected_at = Time.current
      @resource.rejected_by = current_user
      @resource.status = :rejected

      if @resource.save
        redirect_to([:admin, @resource], alert: "#{controller_name.humanize} has been rejected.")
      else
        redirect_on_error
      end
    end

    # POST /admin/resources/:id/restore
    def restore
      @resource.undiscard

      redirect_to [:admin, @resource], notice: "#{controller_name.humanize} was successfully restored."
    end

    private

    def redirect_on_error
      redirect_to(admin_root_url, alert: "Error! #{@resource.errors.full_messages.join(". ")}.")
    end

    def set_resource
      @resource = controller_name.classify.constantize.find(params[:id])
      authorize([:admin, @resource])
    end
  end
end
