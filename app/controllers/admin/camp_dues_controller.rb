module Admin
  class CampDuesController < ApplicationController
    include Admin::Campable

    private

    def search_index
      @query = @query.for_transaction_id(params[:search][:transaction_id]) if params.dig(:search, :transaction_id).present?

      @camp_deposits_pagy, @camp_deposits = pagy(::CampDeposit.for_transaction_id(params[:search][:transaction_id]), page_param: :camp_deposit) if params.dig(:search, :transaction_id).present?
    end
  end
end