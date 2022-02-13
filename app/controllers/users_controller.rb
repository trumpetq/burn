class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    authorize(:user)
    @pagy, @users = pagy(::User.with_status(:active).order("LOWER(name)"))
  end

  # GET /users/:id
  def show
  end

  private

  def set_user
    @user = ::User.kept.find(params[:id])
    authorize(@user)
  end
end
