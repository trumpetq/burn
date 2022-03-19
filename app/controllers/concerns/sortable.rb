module Sortable
  def param_direction
    params[:direction]&.downcase == "asc" ? "ASC" : "DESC"
  end
end