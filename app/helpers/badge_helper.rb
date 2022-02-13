module BadgeHelper
  def na_badge
    tag.span("N/A", class: "badge bg-light text-dark")
  end

  def no_badge(text = nil)
    yes_or_no_badge(false, text)
  end

  def yes_badge(text = nil)
    yes_or_no_badge(true, text)
  end

  def yes_or_no_badge(value, text = nil)
    if value
      tag.span(text.presence || "Yes", class: "badge bg-success")
    else
      tag.span(text.presence || "No", class: "badge bg-danger")
    end
  end

  def pagy_count_badge(pagy)
    return na_badge unless pagy.present?
    tag.span(number_with_delimiter(pagy.count), class: "badge rounded-pill bg-opacity-50 bg-secondary")
  end
end
