class CampDepositsController < ApplicationController
  include Campable

  def after_new
    redirect_to camp_deposit_url(current_user.camp_deposit) if current_user.camp_deposit.present?
  end
end
