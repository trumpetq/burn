module CardHelper
  def icon_card_header(icon, text, button = nil)
    tag.div(bootstrap_icon(icon) + " " + text + button, class: "card-header")
  end

  def admin_card_header(button = nil)
    tag.div(bootstrap_icon("shield-lock text-danger") + " Admin" + button, class: "card-header")
  end

  def error_card_header(error)
    tag.div(bootstrap_icon("exclamation-octagon") + " Error #{error}", class: "card-header bg-danger text-white")
  end

  def pagy_card_footer(pagy)
    tag.div(pagy_bootstrap_nav(pagy).html_safe, class: "card-footer")
  end
end
