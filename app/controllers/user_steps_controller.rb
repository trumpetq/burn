class UserStepsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    authorize(:user)
    @users = User.all
  end

  # GET /admin/users/:id
  def show
  end

  # GET /admin/users/:id/edit
  def edit
  end

  # PATCH /admin/users/:id
  def update
    if @user.update(permitted_attributes(@user))
      redirect_to user_url(@user), success: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = ::User.find(params[:id])
    authorize([:admin, @user])
  end
end
