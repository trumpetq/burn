module Admin
  class CampJobDescriptionsController < ApplicationController
    include Admin::Campable

    private

    def before_create
      @resource.user = current_user
    end
  end
end
