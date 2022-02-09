module Admin
  class CampsController < ApplicationController
    # GET /camp
    def show
      authorize([:admin, :camp])
    end
  end
end
