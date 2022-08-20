class CampDepositsController < ApplicationController
  include Campable
  before_action :locked, only: [:create, :edit, :update, :pay]

  def before_create
    @resource.pricing_tier = @resource.user.camp_due.pricing_tier if @resource&.user&.camp_due.present?
  end

  def after_create
    @redirect_url = camp_deposit_url(@resource)
  end

  def after_new
    redirect_to(camp_deposit_url(current_user.camp_deposit), notice: "It looks like you already started paying your deposit. Here is your current information.") if current_user&.camp_deposit.present?
  end
end
