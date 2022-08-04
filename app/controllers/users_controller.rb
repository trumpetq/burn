class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  def index
    authorize(:user)
    @pagy, @camping_with_us = pagy(::User.with_plan(:camping_with_us).order_by_name)
  end

  # GET /users/:id
  def show
    @user = ::User.kept.includes(camp_jobs: :camp_job_description).find(params[:id])
    authorize(@user)
  end

  # GET /users/:id/edit
  def edit
    redirect_to(edit_user_registration_url)
  end

  # GET /users/me
  def me
    skip_authorization

    if current_user
      redirect_to(current_user)
    else
      redirect_to(new_user_session_url, notice: "You must be signed in to view your profile.")
    end
  end

  private

  def set_user
    @user = ::User.kept.find(params[:id])
    authorize(@user)
  end
end
