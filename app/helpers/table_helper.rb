module TableHelper
  def table_row_class(resource)
    return unless resource.present?
    if resource.try(:discarded?)
      return "bg-warning bg-opacity-25"
    end
  end
end