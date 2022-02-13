module AlertHelper
  def error_alert(error)
    return unless error.present? && Rails.env.development?
    tag.div(error.message, class: "alert alert-danger")
  end

  def discard_alert(resource)
    return unless resource.try(:discarded?)
    tag.div("#{resource} has been deleted!", class: "alert alert-warning")
  end
end