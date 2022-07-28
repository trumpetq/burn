module Admin
  class CampJobDescriptionsController < ApplicationController
    include Admin::Campable

    private

    def after_show
      @camp_job_definitions_pagy, @camp_job_definitions = pagy(::CampJobDefinition.for_camp_job_description(@resource))
    end

    def before_create
      @resource.user = current_user
    end
  end
end
