module Admin
  class CampDuesController < ApplicationController
    include Admin::Campable

    def search_index
      @query = @query.for_transaction_id(params[:search][:transaction_id]) if params.dig(:search, :transaction_id).present?
    end
  end
end