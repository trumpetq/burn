module Admin
  class CampJobDefinitionsController < ApplicationController
    include Admin::Campable

    private

    def before_create
      @resource.user = current_user
    end
  end
end