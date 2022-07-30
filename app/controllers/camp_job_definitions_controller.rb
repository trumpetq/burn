class CampJobDefinitionsController < ApplicationController
  include Campable

  private

  def search_index
    @query = @query.reorder_by_date
  end
end
