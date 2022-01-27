class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        redirect_to user_url(@user), notice: "User was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH /users/:id
  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to user_url(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy

    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = ::User.find(params[:id])
    authorize(@user)
  end
end
