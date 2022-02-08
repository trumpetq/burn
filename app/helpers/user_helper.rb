module UserHelper
  def user_role_badge(user)
    return na_badge if user.blank?

    css_class =
      case user.role.to_sym
      when :mayor then "badge bg-danger"
      when :leader then "badge bg-warning"
      when :member then "badge bg-success"
      when :guest then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(user.role&.to_s.humanize, class: css_class)
  end

  def user_status_badge(user)
    return na_badge if user.blank?

    css_class =
      case user.status.to_sym
      when :active then "badge bg-success"
      when :confirmed then "badge bg-primary"
      when :banned then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(user.status&.to_s.humanize, class: css_class)
  end

  def user_pronouns_badge(user)
    return na_badge if user.pronouns.blank?

    css_class =
      case user.pronouns.to_sym
      when :he_him then "badge bg-danger"
      when :she_her then "badge bg-primary"
      when :they_them then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(user.pronouns&.to_s.humanize.sub(" ", "/"), class: css_class)
  end

  def user_postal_code_badge(user)
    return unless user.in_bay_area?

    tag.span("Bay area", class: "badge bg-info")
  end
end
