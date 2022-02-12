module CardHelper
  def icon_card_header(icon, text, button = nil)
    tag.div(bootstrap_icon(icon) + " " + text + button, class: "card-header")
  end

  def admin_card_header
    tag.div(bootstrap_icon("shield-lock text-danger") + " Admin", class: "card-header")
  end

  def error_card_header(error)
    tag.div(bootstrap_icon("exclamation-octagon") + " Error #{error}", class: "card-header bg-danger text-white")
  end

  def error_alert(error)
    return unless error.present? && Rails.env.development?
    tag.div(error.message, class: "alert alert-danger")
  end
end
