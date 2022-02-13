module TableHelper
  def admin_table_sort(column:, label:)
    link_to(label, admin_users_path(column: column))
  end

  def table_row_class(resource)
    return unless resource.present?
    if resource.try(:discarded?)
      return "bg-warning bg-opacity-25"
    end
  end
end