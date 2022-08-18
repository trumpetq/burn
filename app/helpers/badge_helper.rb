module BadgeHelper
  def na_badge(style: :word, class_name: nil)
    badge_text =
      case style.to_sym
      when :word then "N/A"
      when :letter then "&ndash;".html_safe
      else
        "Error"
      end

    tag.span(badge_text, class: "badge bg-light text-dark #{class_name}".strip)
  end

  def no_badge(text = nil, tooltip: nil)
    yes_or_no_badge(false, text)
  end

  def yes_badge(text = nil, tooltip: nil)
    yes_or_no_badge(true, text)
  end

  def yes_or_no_badge(value, text = nil, tooltip: nil, class_name: nil)
    badge_text = value ? text.presence || "Yes" : text.presence || "No"

    if tooltip.present?
      if value
        tag.span(badge_text, class: "badge bg-success #{class_name}".strip, data: {bs_toggle: "tooltip", bs_title: tooltip})
      else
        tag.span(badge_text, class: "badge bg-danger #{class_name}".strip, data: {bs_toggle: "tooltip", bs_title: tooltip})
      end
    else
      if value
        tag.span(badge_text, class: "badge bg-success #{class_name}".strip)
      else
        tag.span(badge_text, class: "badge bg-danger #{class_name}".strip)
      end
    end
  end

  def pagy_count_badge(pagy)
    return na_badge unless pagy.present?
    if pagy.respond_to?(:count)
      count_badge(pagy.count)
    else
      count_badge(pagy.to_i)
    end
  end

  def count_badge(count, class_name: "badge rounded-pill bg-opacity-50 bg-secondary", tooltip: nil)
    return na_badge unless count.present?

    if tooltip.present?
      tag.span(number_with_delimiter(count), class: class_name, data: {bs_toggle: "tooltip", bs_title: tooltip})
    else
      tag.span(number_with_delimiter(count), class: class_name)
    end
  end
end
