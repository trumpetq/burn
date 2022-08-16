module Admin
  class NewslettersController < ApplicationController
    include Sortable

    before_action :set_newsletter, only: [:show, :edit, :update, :destroy, :restore, :unsubscribe, :force_delete]

    # GET /admin/newsletters
    def index
      authorize([:admin, :newsletter])

      @query = ::Newsletter.includes(:user).kept
      @query = @query.like_email(params[:search][:email]) if params.dig(:search, :email).present?
      @query = @query.for_user(params[:search][:user_id]) if params.dig(:search, :user_id).present?
      @query = @query.with_list(params[:search][:list]) if params.dig(:search, :list).present?

      @query = @query.order(id: param_direction) if params[:column] == "id"
      @query = @query.order(email: param_direction) if params[:column] == "email"
      @query = @query.order(list: param_direction) if params[:column] == "list"

      @pagy, @newsletters = pagy(@query.order(created_at: :desc), items: 50)
    end

    # GET /admin/newsletters/:id
    def show
    end

    # GET /admin/newsletters/new
    def new
      @newsletter = ::Newsletter.new(email: params[:email], user_id: params[:user_id], list: :general)
      authorize([:admin, @newsletter])
    end

    # POST /admin/newsletters
    def create
      @newsletter = ::Newsletter.new(permitted_attributes([:admin, ::Newsletter]))
      authorize([:admin, @newsletter])
      if @newsletter.save
        redirect_to(admin_newsletter_url(@newsletter), success: "Newsletter was successfully created.")
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
        redirect_to(admin_newsletter_url(@newsletter), success: "Newsletter was successfully updated.")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/newsletters/:id
    def destroy
      @newsletter.discard

      redirect_to(admin_newsletters_url, notice: "Newsletter was successfully destroyed.", status: :see_other)
    end

    # GET /admin/newsletters/export
    def export
      authorize([:admin, :newsletter])
      @general_list = ::Newsletter.with_list(:general).order(email: :asc)
      @general_list_text = @general_list.join(",\n")
      @campers_only_list = ::Newsletter.with_list(:campers_only).order(email: :asc)
      @campers_only_list_text = @campers_only_list.join(",\n")

      not_camping_with_us_user_ids = ::User.not_camping_with_us.pluck(:id)
      @might_go_list = ::Newsletter.subscribed.where.not(user_id: not_camping_with_us_user_ids).or(::Newsletter.subscribed.where(user_id: nil)).order(email: :asc)
      @might_go_list_text = @might_go_list.join(",\n")

      no_plan_user_ids = ::User.with_plan(:none).pluck(:id)
      @no_plan_list = ::Newsletter.subscribed.where.not(user_id: no_plan_user_ids).or(::Newsletter.subscribed.where(user_id: nil)).order(email: :asc)
      @no_plan_list_text = @no_plan_list.join(",\n")
    end

    # PATCH /admin/users/:id/restore
    def restore
      @newsletter.undiscard

      redirect_to(admin_newsletter_url(@newsletter), notice: "Newsletter was successfully restored.", status: :see_other)
    end

    # DELETE /admin/users/:id/force_delete
    def force_delete
      @newsletter.delete

      redirect_to(admin_root_url, notice: "Newsletter was been deleted.", status: :see_other)
    end

    # PATCH /admin/newsletters/:id/unsubscribe
    def unsubscribe
      @newsletter.unsubscribe!
      redirect_to(admin_newsletter_url(@newsletter), notice: "Unsubscribe successfully completed.", status: :see_other)
    end

    private

    def set_newsletter
      @newsletter = ::Newsletter.find(params[:id])
      authorize([:admin, @newsletter])
    end
  end
end
