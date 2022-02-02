class StepsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    authorize(:user)
    @users = User.all
  end

  # GET /admin/users/:id
  def show
  end

  private

  def set_user
    @user = ::User.find(params[:id])
    authorize([:admin, @user])
  end
end
