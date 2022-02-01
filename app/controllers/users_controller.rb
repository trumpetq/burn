class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    authorize(:user)
    @users = User.all
  end

  # GET /users/:id
  def show
  end
  private

  def set_user
    @user = ::User.find(params[:id])
    authorize(@user)
  end
end
