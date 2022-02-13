module CardHelper
  def icon_card_header(icon, text, button: nil, pagy: nil, class_name: nil)
    tag.div(class: "card-header #{class_name}".strip) do
      capture do
        concat bootstrap_icon(icon)
        concat tag.span(text, class: "ms-1 me-1")
        concat pagy_count_badge(pagy) if pagy.present?
        concat button if button.present?
      end
    end
  end

  def error_card_header(error)
    icon_card_header("exclamation-octagon", " Error #{error}", class_name: "bg-danger text-white")
  end

  def pagy_card_footer(pagy)
    tag.div(pagy_bootstrap_nav(pagy).html_safe, class: "card-footer")
  end
end
