module Admin
  class NewslettersController < ApplicationController
    before_action :set_newsletter, only: [:show, :edit, :update, :destroy, :unsubscribe]

    # GET /admin/newsletters
    def index
      authorize([:admin, :newsletter])

      query = ::Newsletter.all
      query = query.for_email(params[:search][:email]) if params.dig(:search, :email).present?
      query = query.for_user(params[:search][:user_id]) if params.dig(:search, :user_id).present?

      @pagy, @newsletters = pagy(query.order(updated_at: :desc))
    end

    # GET /admin/newsletters/:id
    def show
    end

    # GET /admin/newsletters/new
    def new
      @newsletter = ::Newsletter.new
      authorize([:admin, @newsletter])
    end

    # POST /admin/newsletters
    def create
      @newsletter = ::Newsletter.new(permitted_attributes([:admin, ::Newsletter]))
      authorize([:admin, @newsletter])
      if @newsletter.save
        redirect_to admin_newsletter_url(@newsletter), success: "Newsletter was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/newsletters/:id/edit
    def edit
    end

    # PATCH /admin/newsletters/:id
    def update
      if @newsletter.update(permitted_attributes([:admin, @newsletter]))
        redirect_to admin_newsletter_url(@newsletter), success: "Newsletter was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/newsletters/:id
    def destroy
      @newsletter.destroy

      redirect_to admin_newsletters_url, notice: "Newsletter was successfully destroyed."
    end

    # GET /admin/newsletters/export
    def export
      authorize([:admin, :newsletter])
      @general_list = ::Newsletter.with_list(:general).order(email: :asc).join(",\n")
      @campers_only_list = ::Newsletter.with_list(:campers_only).order(email: :asc).join(",\n")

    end

    # POST /admin/newsletters/:id/unsubscribe
    def unsubscribe
      @newsletter.unsubscribe!
      redirect_to admin_newsletter_path(@newsletter), notice: "Unsubscribe successfully completed."
    end

    private

    def set_newsletter
      @newsletter = ::Newsletter.find(params[:id])
      authorize([:admin, @newsletter])
    end
  end
end