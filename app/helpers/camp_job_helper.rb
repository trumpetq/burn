module CampJobHelper
  def camp_timeframe_badge(camp)
    return na_badge unless camp&.timeframe.present?

    css_class =
      case camp.timeframe.to_sym
      when :burn_week then "badge bg-primary"
      when :pre_event then "badge bg-success"
      when :build_week then "badge bg-warning"
      when :strike then "badge bg-secondary"
      when :post_event then "badge bg-secondary"
      when :year_round then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.timeframe&.to_s&.humanize, class: css_class)
  end

  def camp_department_badge(camp)
    return na_badge unless camp&.department.present?

    css_class =
      case camp.department.to_sym
      when :none then "badge bg-secondary"
      when :kitchen then "badge bg-success"
      when :build then "badge bg-primary"
      when :power then "badge bg-secondary"
      when :fun then "badge bg-danger"
      when :bureaucracy then "badge bg-dark"
      else
        "badge bg-dark"
      end

    tag.span(camp.department&.to_s&.humanize, class: css_class)
  end

  def camp_points_badge(count)
    return danger_count_badge(0) if count.blank? || count.zero?

    if count >= Settings.camp.min_points
      success_count_badge(count)
    else
      warning_count_badge(count)
    end
  end
end