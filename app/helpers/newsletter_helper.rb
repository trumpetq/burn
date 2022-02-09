module NewsletterHelper
  def newsletter_list_badge(newsletter)
    return na_badge if newsletter.blank?

    css_class =
      case newsletter.list.to_sym
      when :unsubscribed then "badge bg-secondary"
      when :general then "badge bg-primary"
      when :campers_only then "badge bg-success"
      else
        "badge bg-dark"
      end

    tag.span(newsletter.list&.to_s.humanize, class: css_class)
  end
end