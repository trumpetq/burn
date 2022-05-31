module Admin
  module Campable
    extend ActiveSupport::Concern

    included do
      before_action :set_resource, only: [:show, :edit, :update, :destroy, :active, :approve, :complete, :force_delete, :pay, :reject, :restore, :skip]
      before_action :set_redirect_url, only: [:destroy, :force_delete]
    end

    # GET /admin/resources
    def index
      authorize([:admin, controller_name.classify.underscore.to_sym])
      @pagy, @resources = pagy(controller_name.classify.constantize.includes(:user).order(updated_at: :desc))
      after_index if defined?(after_index)
    end

    # GET /admin/resources/:id
    def show
      after_show if defined?(after_show)
    end

    # GET /admin/resources/new
    def new
      @resource = controller_name.classify.constantize.new
      authorize([:admin, @resource])
      if params[:user_id]
        @resource.user = ::User.find(params[:user_id])
      end
      after_new if defined?(after_new)
    end

    # POST /admin/resources
    def create
      @resource = controller_name.classify.constantize.new(permitted_attributes([:admin, controller_name.classify.constantize]))
      authorize([:admin, @resource])
      if @resource.save
        redirect_to([:admin, @resource], success: "#{admin_link_to_resource} was successfully created.")
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
        redirect_to([:admin, @resource], success: "#{admin_link_to_resource} was successfully updated.")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/resources/:id
    def destroy
      @user = @resource.user

      if @resource.respond_to?(:discard)
        @resource.discard
      else
        @resource.destroy
      end

      redirect_to(@redirect_url, warning: "#{controller_name.singularize.humanize} was successfully destroyed.", status: :see_other)
    end

    # PATCH /admin/resources/:id/active
    def active
      @resource.status = :active

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      active_before_save if defined?(active_before_save)

      if @resource.save
        active_after_save if defined?(active_after_save)

        redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} has is now active.", status: :see_other)
      else
        redirect_on_error
      end
    end

    # PATCH /admin/resources/:id/approve
    def approve
      @resource.approved_at = Time.current
      @resource.approved_by = current_user
      @resource.status = :approved

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      approve_before_save if defined?(approve_before_save)

      if @resource.save
        approve_after_save if defined?(approve_after_save)

        redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} has been approved.", status: :see_other)
      else
        redirect_on_error
      end
    end

    # PATCH /admin/resources/:id/complete
    def complete
      @resource.completed_at = Time.current
      @resource.completed_by = current_user
      @resource.status = :completed

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      complete_before_save if defined?(complete_before_save)

      if @resource.save
        complete_after_save if defined?(complete_after_save)

        redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} has been completed.", status: :see_other)
      else
        redirect_on_error
      end
    end

    # DELETE /admin/resources/:id/force_delete
    def force_delete
      @resource.destroy

      redirect_to(@redirect_url, alert: "#{controller_name.singularize.humanize} was successfully deleted.", status: :see_other)
    end

    # PATCH /admin/resources/:id/pay
    def pay
      @resource.paid_at = Time.current
      @resource.paid_by = current_user
      @resource.status = :paid

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      pay_before_save if defined?(pay_before_save)

      if @resource.save
        pay_after_save if defined?(pay_after_save)

        redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} has been paid.", status: :see_other)
      else
        redirect_on_error
      end
    end

    # PATCH /admin/resources/:id/restore
    def restore
      @resource.undiscard

      redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} was successfully restored.", status: :see_other)
    end

    # PATCH /admin/resources/:id/reject
    def reject
      @resource.rejected_at = Time.current
      @resource.rejected_by = current_user
      @resource.status = :rejected

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      reject_before_save if defined?(reject_before_save)

      if @resource.save
        reject_after_save if defined?(reject_after_save)

        redirect_to([:admin, @resource], alert: "#{admin_link_to_resource} has been rejected.", status: :see_other)
      else
        redirect_on_error
      end
    end

    # PATCH /admin/resources/:id/skip
    def skip
      @resource.skipped_at = Time.current
      @resource.skipped_by = current_user
      @resource.status = :skipped

      @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

      skip_before_save if defined?(skip_before_save)

      if @resource.save
        skip_after_save if defined?(skip_after_save)

        redirect_to([:admin, @resource], notice: "#{admin_link_to_resource} has been skipped.", status: :see_other)
      else
        redirect_on_error
      end
    end

    private

    def redirect_on_error
      redirect_to(admin_root_url, alert: "Error! #{@resource.errors.full_messages.join(". ")}.", status: :see_other)
    end

    def set_resource
      @resource = controller_name.classify.constantize.find(params[:id])
      authorize([:admin, @resource])
    end

    def send_email?
      params.dig(controller_name.singularize, :send_email) == "1"
    end

    def admin_link_to_resource
      view_context.link_to_policy(policy([:admin, @resource]).show?, controller_name.singularize.humanize, [:admin, @resource])
    end

    def set_redirect_url
      @redirect_url = admin_root_url
      @redirect_url = admin_user_url(@resource.user) if @resource.user.present? && !@resource.is_a?(::User)
    end
  end
end
