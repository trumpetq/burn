module Admin
  class CampTicketsController < ApplicationController
    include Admin::Campable

    private

    def after_new
      @resource.user = ::User.find(params[:user_id]) if params[:user_id].present?
    end
  end
end