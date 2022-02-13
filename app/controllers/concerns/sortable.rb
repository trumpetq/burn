module Sortable
  def param_direction
    params[:direction] == "asc" ? "ASC" : "DESC"
  end
end