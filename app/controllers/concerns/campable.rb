module Campable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: [:show, :edit, :update, :destroy, :pay]
  end

  # GET /resources
  def index
    authorize(controller_name.classify.underscore.to_sym)

    if controller_name.classify.constantize.new.multiple?
      @query = controller_name.classify.constantize.includes(:user).order(updated_at: :desc)

      search_index if defined?(search_index)

      @pagy, @resources = pagy(@query)
    else

      @resource = controller_name.classify.constantize.for_user(current_user).take

      after_index if defined?(after_index)

      if @resource.present? && !@resource.try(:discarded?)
        redirect_to(@redirect_url || @resource)
      else
        redirect_to(@redirect_url || root_url, warning: "No #{controller_name.singularize.humanize(capitalize: false)} found.")
      end
    end
  end

  # GET /resources/:id
  def show
    after_show if defined?(after_show)
  end

  # GET /resources/new
  def new
    @resource = controller_name.classify.constantize.new
    authorize(@resource)
    after_new if defined?(after_new)
  end

  # POST /resources
  def create
    @resource = controller_name.classify.constantize.new(permitted_attributes(controller_name.classify.constantize))
    @resource.user = current_user
    @resource.applied_at = Time.current if @resource.respond_to?(:applied_at)
    @resource.status = :active

    authorize(@resource)

    before_create if defined?(before_create)

    if @resource.save
      after_create if defined?(after_create)

      redirect_to(@redirect_url || user_url(current_user), success: "#{link_to_resource} was created.")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /resources/:id/edit
  def edit
  end

  # PATCH /resources/:id
  def update
    if @resource.update(permitted_attributes(@resource))
      redirect_to(@redirect_url || @resource, success: "#{link_to_resource} was updated.")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /resources/:id
  def destroy
    if @resource.respond_to?(:discard)
      @resource.discard
    else
      @resource.destroy
    end

    redirect_to(@redirect_url || user_url(current_user), notice: "#{controller_name.singularize.humanize} was successfully destroyed.", status: :see_other)
  end

  # PATCH /resources/:id/pay
  def pay
    @resource.paid_at = Time.current
    @resource.paid_by = current_user
    @resource.status = :paid

    @resource.update(permitted_attributes([:admin, @resource])) if params[controller_name.singularize].present?

    if @resource.save
      redirect_to(@redirect_url || user_url(current_user), notice: "#{link_to_resource} has been marked as paid.", status: :see_other)
    else
      redirect_on_error
    end
  end

  private

  def set_resource
    @resource = controller_name.classify.constantize.find(params[:id])
    authorize(@resource)
  end

  def link_to_resource
    view_context.link_to_policy(policy(@resource).show?, controller_name.singularize.humanize, @resource)
  end

  def redirect_on_error
    redirect_to(root_url, alert: "Error! #{@resource.errors.full_messages.join(". ")}.", status: :see_other)
  end
end
