module Admin
  class CampJobsController < ApplicationController
    include Admin::Campable

    private

    def search_index
      @query = @query.includes(:camp_job_description)
    end

    def active_after_save
      @resource.update(user: nil)
    end
  end
end