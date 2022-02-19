class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy, :unsubscribe]

  # GET /newsletters
  def index
    authorize(:newsletter)

    if current_user && current_user.newsletter.present?
      redirect_to newsletter_path(current_user.newsletter), notice: "We found your subscription."
    else
      redirect_to new_newsletter_path
    end
  end

  # GET /newsletters/:id
  def show
  end

  # GET /newsletters/new
  def new
    @newsletter = ::Newsletter.new(email: params[:email])
    authorize(@newsletter)
  end

  # POST /newsletters
  def create
    @newsletter = ::Newsletter.kept.for_user(current_user).take if current_user

    if @newsletter.present?
      @newsletter.assign_attributes(permitted_attributes(::Newsletter))
    else
      @newsletter = ::Newsletter.new(permitted_attributes(::Newsletter))
      @newsletter.user = current_user
    end

    authorize(@newsletter)
    @newsletter.list = :general if @newsletter.list == :unsubscribed

    if @newsletter.save
      if current_user
        redirect_to newsletter_url(@newsletter), success: "Subscription has been created."
      else
        redirect_to root_url, success: "Subscription has been created."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /newsletters/:id/edit
  def edit
  end

  # PATCH /newsletters/:id
  def update
    if @newsletter.update(permitted_attributes(@newsletter))
      redirect_to newsletter_url(@newsletter), success: "Subscription has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /newsletters/:id
  def destroy
    @newsletter.unsubscribe!

    redirect_to root_url, notice: "You are now unsubscribed.", status: :see_other
  end

  # PATCH /newsletters/:id/unsubscribe
  def unsubscribe
    @newsletter.unsubscribe!

    redirect_to root_url, notice: "You are now unsubscribed.", status: :see_other
  end

  private

  def set_newsletter
    @newsletter = ::Newsletter.kept.find(params[:id])
    authorize(@newsletter)
  end
end
