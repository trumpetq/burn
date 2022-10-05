module TableHelper
  def admin_table_sort(path:, column:, label:)
    if column == params[:column]
      link_to(sort_icon + " " + label, polymorphic_path([:admin, path.to_sym], column: column, direction: next_direction), data: {turbo_frame: path.to_s})
    else
      link_to(label, polymorphic_path([:admin, path.to_sym], column: column, direction: "asc"), data: {turbo_frame: path.to_s})
    end
  end

  def table_row_class(resource)
    return unless resource.present?
    "bg-danger bg-opacity-25" if resource.try(:discarded?)
  end

  def next_direction
    params[:direction] == "asc" ? "desc" : "asc"
  end

  def sort_icon
    params[:direction] == "asc" ? bootstrap_icon("caret-up-fill") : bootstrap_icon("caret-down-fill")
  end
end