module Admin
  class PagesController < ApplicationController
    before_action :handle_authorization

    # GET /admin
    def home
    end

    # GET /admin/system
    def system
    end

    private

    def handle_authorization
      authorize([:admin, :page])
    end
  end
end