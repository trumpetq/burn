
module UserStepHelper
  def user_step_status_badge(user_step)
    return na_badge if user_step.blank?

    css_class =
      case user_step.status.to_sym
      when :unavailable then "badge bg-secondary"
      when :active then "badge bg-primary"
      when :closed then "badge bg-secondary"
      when :completed then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(user_step.status.titleize, class: css_class)
  end
end