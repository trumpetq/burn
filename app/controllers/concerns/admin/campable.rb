module Admin
  module Campable
    extend ActiveSupport::Concern

    included do
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
    end

    # GET /admin/resources
    def index
      authorize([:admin, controller_name.classify.underscore.to_sym])
      @resources = controller_name.classify.constantize.order(updated_at: :desc)
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
      @resource.destroy

      redirect_to admin_root_path, notice: "#{controller_name.humanize} was successfully destroyed."
    end

    private

    def set_resource
      @resource = controller_name.classify.constantize.find(params[:id])
      authorize([:admin, @resource])
    end
  end
end
