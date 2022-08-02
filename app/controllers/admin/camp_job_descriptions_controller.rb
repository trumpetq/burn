module Admin
  class CampJobDescriptionsController < ApplicationController
    include Admin::Campable

    private

    def after_show
      @camp_jobs_pagy, @camp_jobs = pagy(::CampJob.for_camp_job_description(@resource))
    end

    def before_create
      @resource.user = current_user
    end
  end
end
