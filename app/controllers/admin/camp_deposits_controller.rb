module Admin
  class CampDepositsController < ApplicationController
    include Admin::Campable

    private

    def search_index
      @query = @query.for_transaction_id(params[:search][:transaction_id]) if params.dig(:search, :transaction_id).present?

      @camp_dues_pagy, @camp_dues = pagy(::CampDue.for_transaction_id(params[:search][:transaction_id]), page_param: :camp_due) if params.dig(:search, :transaction_id).present?
    end
  end
end