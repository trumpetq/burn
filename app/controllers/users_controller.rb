class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :confirm, :ticket]
  before_action :require_user, only: [:status]

  # GET /users
  def index
    authorize(:user)
    @pagy_confirmed_users, @confirmed_users = pagy(::User.includes(avatar_attachment: :blob).with_status(:confirmed).order_by_name, items: 100, page_param: :confirmed)
    @pagy_maybe_users, @maybe_users = pagy(::User.includes(avatar_attachment: :blob).with_plan(:camping_with_us).with_status(:active).order_by_name, items: 25, page_param: :maybe)
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

  # GET /users/status
  def status

    authorize(current_user)
    @user = current_user
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

  # PATCH /users/:id/confirm
  def confirm
    @user.update(status: :confirmed)

    redirect_to(ticket_user_path(@user), success: "You spot in camp is now confirmed. See you at Burning Man.", status: :see_other)
  end

  private

  def set_user
    @user = ::User.kept.find(params[:id])
    authorize(@user)
  end

  def require_user
    return if current_user.present?
    redirect_to(new_user_session_url, alert: "You must sign in first.")
  end
end
