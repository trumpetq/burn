module Campable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: [:show, :edit, :update]
  end

  # GET /resources
  def index
    authorize(controller_name.classify.underscore.to_sym)

    @resource = controller_name.classify.constantize.for_user(current_user).kept.take

    if @resource.present?
      redirect_to @resource
    else
      redirect_to root_path, warning: "No #{controller_name.humanize(capitalize: false)} found."
    end
  end

  # GET /resources/:id
  def show
  end

  # GET /resources/new
  def new
    @resource = controller_name.classify.constantize.new
    authorize(@resource)
  end

  # POST /resources
  def create
    @resource = controller_name.classify.constantize.new(permitted_attributes(controller_name.classify.constantize))
    @resource.user = current_user
    @resource.applied_at = Time.current
    @resource.status = :active

    authorize(@resource)
    if @resource.save
      redirect_to @resource, success: "#{controller_name.humanize} was created."
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
      redirect_to @resource, success: "#{controller_name.humanize} was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_resource
    @resource = controller_name.classify.constantize.kept.find(params[:id])
    authorize(@resource)
  end
end
