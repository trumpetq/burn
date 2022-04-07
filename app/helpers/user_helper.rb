module UserHelper
  def user_role_badge(user)
    return na_badge unless user.present?

    css_class =
      case user.role.to_sym
      when :mayor then "badge bg-danger"
      when :leader then "badge bg-warning"
      when :member then "badge bg-success"
      when :guest then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(user.role&.to_s&.humanize, class: css_class)
  end

  def user_status_badge(user)
    return na_badge unless user.present?

    css_class =
      case user.status.to_sym
      when :active then "badge bg-success"
      when :confirmed then "badge bg-primary"
      when :banned then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(user.status&.to_s&.humanize, class: css_class)
  end

  def user_plan_badge(user)
    return na_badge unless user.present?

    css_class =
      case user.plan.to_sym
      when :none then "badge bg-secondary"
      when :camping_with_us then "badge bg-success"
      when :thinking_about_it then "badge bg-info"
      when :camping_elsewhere then "badge bg-warning"
      when :not_going then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(user.plan&.to_s&.humanize, class: css_class)
  end

  def user_pronouns_badge(user)
    return na_badge unless user&.pronouns.present?

    css_class =
      case user.pronouns.to_sym
      when :he_him then "badge bg-danger"
      when :she_her then "badge bg-primary"
      when :they_them then "badge bg-secondary"
      when :she_they then "badge bg-secondary"
      when :he_they then "badge bg-secondary"
      when :all then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(user.pronouns&.to_s&.humanize&.sub(" ", "/"), class: css_class)
  end

  def user_postal_code_badge(user)
    return unless user&.in_bay_area?

    tag.span("Bay area", class: "badge bg-info")
  end

  def user_social_media_icons(user)
    if user.social_media?
      capture do
        concat link_to(bootstrap_icon("facebook"), user.facebook_url, target: "_blank", class: "me-2") if user.facebook_url.present?
        concat link_to(bootstrap_icon("instagram"), user.instagram_url, target: "_blank", class: "me-2") if user.instagram_url.present?
        concat link_to(bootstrap_icon("twitter"), user.twitter_url, target: "_blank", class: "me-2") if user.twitter_url.present?
      end
    end
  end

  def admin_user_badge(user)
    return na_badge if user.blank?
    tag.span(link_to_policy(policy([:admin, user]).show?, user, admin_user_path(user)), class: "badge bg-light")
  end

  def user_badge(user)
    return na_badge if user.blank?
    tag.span(link_to_policy(policy(user).show?, user, user_path(user)), class: "badge bg-light")
  end

  def user_link(user)
    return na_badge if user.blank?
    link_to_policy(policy(user).show?, user, user_path(user))
  end

  def admin_user_link(user)
    return na_badge if user.blank?
    link_to_policy(policy([:admin, user]).show?, user, admin_user_path(user))
  end

  def user_camp_status_badge(user)
    return na_badge if user.blank?

    capture do
      concat camp_status_badge(user.camp_application, style: :letter, class_name: "me-1")
      concat camp_status_badge(user.camp_interview, style: :letter, class_name: "me-1")
      concat user_has_tickets_badge(user, style: :letter, class: "me-1")
    end
  end

  def user_has_ticket_badge(user, style: :word, class_name: nil)
    return na_badge(style: style, class_name: class_name) if user.blank?

    if user.has_ticket?
      ticket_text = "Yes"
      css_class = "badge bg-success"
    else
      ticket_text = "No"
      css_class = "badge bg-danger"
    end

    badge_text =
      case style.to_sym
      when :word then ticket_text
      when :letter then ticket_text.upcase.first
      else
        "Error"
      end

    tag.span(badge_text, class: "#{css_class} #{class_name}".strip)
  end
end
