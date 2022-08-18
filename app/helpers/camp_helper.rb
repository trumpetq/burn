module CampHelper
  def camp_status_badge(camp, style: :word, class_name: nil, tooltip: nil)
    return na_badge(style: style, class_name: class_name) unless camp&.status.present?

    css_class =
      case camp.status.to_sym
      when :unavailable then "badge bg-secondary"
      when :active then "badge bg-info"
      when :assigned then "badge bg-secondary"
      when :approved then "badge bg-primary"
      when :closed then "badge bg-warning"
      when :completed then "badge bg-success"
      when :no_response then "badge bg-secondary"
      when :refunded then "badge bg-warning"
      when :rejected then "badge bg-danger"
      when :skipped then "badge bg-primary"
      when :paid then "badge bg-primary"
      else
        "badge bg-dark"
      end

    badge_text =
      case style.to_sym
      when :word then camp.status&.to_s&.humanize
      when :letter then camp.status&.to_s&.upcase&.first
      else
        "Error"
      end

    if tooltip.present?
      tag.span(badge_text, class: "#{css_class} #{class_name}".strip, data: {bs_toggle: "tooltip", bs_title: tooltip})
    else
      tag.span(badge_text, class: "#{css_class} #{class_name}".strip)
    end
  end
end
