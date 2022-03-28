module CampHelper
  def camp_status_badge(camp, style: :word, class_name: nil)
    return na_badge(style: style, class_name: class_name) unless camp&.status.present?

    css_class =
      case camp.status.to_sym
      when :unavailable then "badge bg-secondary"
      when :active then "badge bg-info"
      when :assigned then "badge bg-secondary"
      when :approved then "badge bg-primary"
      when :completed then "badge bg-success"
      when :closed then "badge bg-warning"
      when :rejected then "badge bg-danger"
      when :skipped then "badge bg-primary"
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

    tag.span(badge_text, class: "#{css_class} #{class_name}".strip)
  end

  def camp_vaccine_status_badge(camp)
    return na_badge unless camp&.vaccine_status.present?

    css_class =
      case camp.vaccine_status.to_sym
      when :unvaccinated then "badge bg-danger"
      when :vaccinated then "badge bg-primary"
      when :vaccinated_and_boosted then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(camp.vaccine_status&.to_s&.humanize, class: css_class)
  end
end
