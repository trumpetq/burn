
module CampHelper
  def camp_status_badge(camp)
    return na_badge if camp.blank?

    css_class =
      case camp.status.to_sym
      when :unavailable then "badge bg-secondary"
      when :active then "badge bg-primary"
      when :closed then "badge bg-secondary"
      when :completed then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(camp.status&.to_s.humanize, class: css_class)
  end

  def camp_vaccine_status_badge(camp)
    return na_badge if camp.blank?

    css_class =
      case camp.vaccine_status.to_sym
      when :unvaccinated then "badge bg-danger"
      when :vaccinated then "badge bg-primary"
      when :vaccinated_and_boosted then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(camp.vaccine_status&.to_s.humanize, class: css_class)
  end
end