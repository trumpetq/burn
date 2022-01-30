module UserHelper
  def user_role_badge(user)
    return na_badge if user.blank?

    css_class =
      case user.role_enum.to_sym
      when :mayor then "badge bg-danger"
      when :leader then "badge bg-warning"
      when :member then "badge bg-success"
      when :guest then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(user.role_enum.titleize, class: css_class)
  end

  def user_status_badge(user)
    return na_badge if user.blank?

    css_class =
      case user.status_enum.to_sym
      when :active then "badge bg-success"
      when :confirmed then "badge bg-primary"
      when :banned then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(user.status_enum.titleize, class: css_class)
  end
end
