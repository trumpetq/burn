class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    authorize(:user)
    @pagy, @camping_with_us = pagy(::User.with_plan(:camping_with_us).order_by_name)
  end

  # GET /users/:id
  def show
  end

  # GET /users/:id/edit
  def edit
    redirect_to edit_user_registration_url
  end

  private

  def set_user
    @user = ::User.kept.find(params[:id])
    authorize(@user)
  end
end
