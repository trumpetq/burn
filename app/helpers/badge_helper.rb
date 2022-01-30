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
end
