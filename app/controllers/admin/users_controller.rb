module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /admin/users
    def index
      authorize([:admin, :user])
      @pagy, @users = pagy(::User.all)
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
      @user.destroy

      redirect_to admin_users_url, notice: "User was successfully destroyed.", status: :see_other
    end

    private

    def set_user
      @user = ::User.find(params[:id])
      authorize([:admin, @user])
    end
  end
end
