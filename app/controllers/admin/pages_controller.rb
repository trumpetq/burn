module Admin
  class PagesController < ApplicationController
    before_action :handle_authorization

    # GET /admin
    def home
    end

    # GET /admin/system
    def system
      flash.now[:success] = "This is a <b>success</b>.".html_safe
      flash.now[:notice] = "This is a <b>notice</b>.".html_safe
      flash.now[:warning] = "This is a <b>warning</b>.".html_safe
      flash.now[:alert] = "This is an <b>alert</b>.".html_safe
    end

    private

    def handle_authorization
      authorize([:admin, :page])
    end
  end
end