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
    if pagy.respond_to?(:count)
      count_badge(pagy.count)
    else
      count_badge(pagy.to_i)
    end
  end

  def count_badge(count, class_name: "badge rounded-pill bg-opacity-50 bg-secondary")
    return na_badge unless count.present?

    tag.span(number_with_delimiter(count), class: class_name)
  end
end
