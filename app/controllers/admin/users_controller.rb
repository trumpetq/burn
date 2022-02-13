module Admin
  class UsersController < ApplicationController
    include Sortable
    before_action :set_user, only: [:show, :edit, :update, :destroy, :restore]

    # GET /admin/users
    def index
      authorize([:admin, :user])

      query = ::User.all
      query = query.order(id: param_direction) if params[:column] == "id"
      query = query.order("LOWER(name) #{param_direction}") if params[:column] == "name"
      query = query.order("LOWER(playa_name) #{param_direction}") if params[:column] == "playa_name"
      query = query.order(email: param_direction) if params[:column] == "email"

      @pagy, @users = pagy(query)
    end

    # GET /admin/users/:id
    def show
      # @user.generate_steps
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

    # POST /admin/users/:id/restore
    def restore
      @user.undiscard

      redirect_to admin_user_url(@user), notice: "User was successfully restored."
    end

    private

    def set_user
      @user = ::User.find(params[:id])
      authorize([:admin, @user])
    end
  end
end
