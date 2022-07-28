module Admin
  class CampJobsController < ApplicationController
    include Admin::Campable

    def search_index
      @query = @query.includes(camp_job_definition: :camp_job_description)
    end
  end
end