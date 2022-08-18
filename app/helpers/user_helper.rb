module UserHelper
  def user_role_badge(user)
    return na_badge unless user.present?

    css_class =
      case user.role.to_sym
      when :mayor then "badge bg-danger"
      when :leader then "badge bg-warning"
      when :camper then "badge bg-success"
      when :member then "badge bg-primary"
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
      when :active then "badge bg-primary"
      when :confirmed then "badge bg-success"
      when :banned then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(user.status&.to_s&.humanize, class: css_class)
  end

  def user_diet_badge(user)
    return na_badge unless user&.diet.present?

    css_class =
      case user.diet.to_sym
      when :omnivore then "badge bg-secondary"
      when :vegetarian then "badge bg-primary"
      when :vegan then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(user.diet&.to_s&.humanize, class: css_class)
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

  def user_bay_area_badge(user)
    return unless user&.in_bay_area?

    tag.span("Bay area", class: "badge bg-secondary")
  end

  def user_social_media_icons(user)
    if user.social_media?
      capture do
        concat(link_to(bootstrap_icon("facebook"), user.facebook_url, target: "_blank", class: "me-2")) if user.facebook_url.present?
        concat(link_to(bootstrap_icon("instagram"), user.instagram_url, target: "_blank", class: "me-2")) if user.instagram_url.present?
        concat(link_to(bootstrap_icon("tiktok"), user.tiktok_url, target: "_blank", class: "me-2")) if user.tiktok_url.present?
        concat(link_to(bootstrap_icon("twitter"), user.twitter_url, target: "_blank", class: "me-2")) if user.twitter_url.present?
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

  def user_camp_status_badge(user)
    return na_badge if user.blank?

    capture do
      concat(camp_status_badge(user.camp_application, style: :letter, class_name: "me-1", tooltip: "Application"))
      concat(camp_status_badge(user.camp_interview, style: :letter, class_name: "me-1", tooltip: "Interview"))
      concat(camp_status_badge(user.camp_due, style: :letter, class_name: "me-1", tooltip: "Dues"))
      concat(camp_status_badge(user.camp_deposit, style: :letter, class_name: "me-1", tooltip: "Deposit"))
      concat(camp_points_badge(user, class_name: "me-1", tooltip: "Points"))
      concat(user_has_ticket_badge(user, style: :letter, class_name: "me-1", tooltip: "Ticket"))
      concat(user_has_wap_badge(user, style: :letter, class_name: "me-1", tooltip: "Ticket"))

    end
  end

  def user_location_badge(user)
    return if user.blank?
    capture do
      concat(user.country_name) if user.country_code.present?
      concat(", #{user.postal_code}") if user.postal_code.present?
      if user.in_bay_area?
        concat(" ")
        concat(user_bay_area_badge(user))
      end
    end
  end

  def user_has_ticket_badge(user, style: :word, class_name: nil, tooltip: nil)
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

    if tooltip.present?
      tag.span(badge_text, class: "#{css_class} #{class_name}".strip, data: {bs_toggle: "tooltip", bs_title: tooltip})
    else
      tag.span(badge_text, class: "#{css_class} #{class_name}".strip)
    end
  end
end
