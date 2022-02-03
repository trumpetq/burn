
module StepHelper
  def step_status_badge(step)
    return na_badge if step.blank?

    css_class =
      case step.status.to_sym
      when :unavailable then "badge bg-secondary"
      when :active then "badge bg-primary"
      when :closed then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(step.status.titleize, class: css_class)
  end
end