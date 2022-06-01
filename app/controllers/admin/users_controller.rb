module Admin
  class UsersController < ApplicationController
    include Sortable

    before_action :set_user, only: [:show, :edit, :update, :destroy, :restore, :remove_avatar]

    # GET /admin/users
    def index
      authorize([:admin, :user])

      query = ::User.kept

      query = query.like_name(params[:search][:name]) if params.dig(:search, :name).present?
      query = query.with_role(params[:search][:role]) if params.dig(:search, :role).present?
      query = query.like_email(params[:search][:email]) if params.dig(:search, :email).present?
      query = query.with_plan(params[:search][:plan]) if params.dig(:search, :plan).present?

      query = query.order(id: param_direction) if params[:column] == "id"
      query = query.order("LOWER(name) #{param_direction}") if params[:column] == "name"
      query = query.order("LOWER(playa_name) #{param_direction}") if params[:column] == "playa_name"
      query = query.order(email: param_direction) if params[:column] == "email"
      query = query.order(status: param_direction) if params[:column] == "status"
      query = query.order(plan: param_direction) if params[:column] == "plan"
      query = query.order(role: param_direction) if params[:column] == "role"

      query = query.order(updated_at: :desc)
      @pagy, @users = pagy(query, items: 50)
    end

    # GET /admin/users/:id
    def show
    end

    # GET /admin/users/new
    def new
      @user = ::User.new
      authorize([:admin, @user])
    end

    # POST /admin/users
    def create
      @user = ::User.new(permitted_attributes([:admin, ::User]))
      authorize([:admin, @user])
      if @user.save
        redirect_to admin_user_url(@user), success: "User was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/users/:id/edit
    def edit
    end

    # PATCH /admin/users/:id
    def update
      if @user.update(permitted_attributes([:admin, @user]))
        redirect_to admin_user_url(@user), success: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/users/:id
    def destroy
      @user.discard

      redirect_to admin_users_url, notice: "User was successfully destroyed.", status: :see_other
    end

    # PATCH /admin/users/:id/restore
    def restore
      @user.undiscard

      redirect_to admin_user_url(@user), notice: "User was successfully restored.", status: :see_other
    end

    # PATCH /admin/users/:id/remove_avatar
    def remove_avatar
      @user.update(avatar: nil)

      redirect_to admin_user_url(@user), notice: "Photo has been removed.", status: :see_other
    end

    private

    def set_user
      @user = ::User.find(params[:id])
      authorize([:admin, @user])
    end
  end
end
