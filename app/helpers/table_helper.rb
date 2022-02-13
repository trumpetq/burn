module TableHelper
  def admin_table_sort(column:, label:)
    if column == params[:column]
      link_to(sort_icon + " " + label, admin_users_path(column: column, direction: next_direction), data: {turbo_frame: "users"})
    else
      link_to(label, admin_users_path(column: column, direction: "asc"), data: {turbo_frame: "users"})
    end
  end

  def table_row_class(resource)
    return unless resource.present?
    if resource.try(:discarded?)
      "bg-warning bg-opacity-25"
    end
  end

  def next_direction
    params[:direction] == "asc" ? "desc" : "asc"
  end

  def sort_icon
    params[:direction] == "asc" ? bootstrap_icon("caret-up-fill") : bootstrap_icon("caret-down-fill")
  end
end