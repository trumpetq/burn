module Admin
  class CampJobDefinitionsController < ApplicationController
    include Admin::Campable

    private

    def search_index
      @query = @query.includes(:camp_job)
    end

    def before_create
      @resource.user = current_user
    end
  end
end