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

  # GET /users/new
  def new
    @user = User.new
    authorize(@user)
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(permitted_attributes[:user])
    authorize(@user)

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
    if @user.update(permitted_attributes(@user))
      redirect_to user_url(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
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
