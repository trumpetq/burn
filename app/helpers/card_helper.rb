module CardHelper
  def card_header(icon, text, buttons: [], pagy: nil, class_name: nil)
    tag.div(class: "card-header #{class_name}".strip) do
      capture do
        concat bootstrap_icon(icon)
        concat tag.span(text, class: "ms-1 me-1")
        concat pagy_count_badge(pagy) if pagy.present?

        concat(
          tag.div(class: "card-header-button float-end") do
            if buttons.present?
              buttons.map do
                concat tag.div(class: "spacer d-inline-block ms-2")
                concat _1
              end
            end

            yield if block_given?
          end
        )
      end
    end
  end

  def error_card_header(error)
    card_header("exclamation-octagon", "Error #{error}", class_name: "bg-danger text-white")
  end

  def pagy_card_footer(pagy)
    return if pagy.blank? || pagy.pages == 1
    tag.div(pagy_bootstrap_nav(pagy).html_safe, class: "card-footer")
  end
end
