module CampTicketHelper
  def camp_availability_badge(camp)
    return na_badge unless camp&.availability.present?

    css_class =
      case camp.availability.to_sym
      when :using_myself then "badge bg-primary"
      when :for_a_friend then "badge bg-secondary"
      when :for_sale then "badge bg-success"
      when :wanted then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.availability&.to_s&.humanize, class: css_class)
  end

  def camp_location_badge(camp)
    return na_badge unless camp&.location.present?

    css_class =
      case camp.location.to_sym
      when :physical_ticket then "badge bg-success"
      when :will_call then "badge bg-secondary"
      else
        "badge bg-dark"
      end

    tag.span(camp.location&.to_s&.humanize, class: css_class)
  end

  def camp_ticket_type_badge(camp)
    return na_badge unless camp&.ticket_type.present?

    css_class =
      case camp.ticket_type.to_sym
      when :ticket then "badge bg-success"
      when :vehicle_pass then "badge bg-primary"
      else
        "badge bg-dark"
      end

    tag.span(camp.ticket_type&.to_s&.humanize, class: css_class)
  end

  def camp_sale_badge(camp)
    return na_badge unless camp&.sale.present?

    css_class =
      case camp.sale.to_sym
      when :main, :ticket_aid_program, :step, :kid_ticket, :omg then "badge bg-secondary"
      when :steward then "badge bg-success"
      when :fomo, :invitation_to_the_future then "badge bg-primary"
      when :staff, :art_project then "badge badge-warning"
      when :other then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.sale&.to_s&.humanize, class: css_class)
  end

  def camp_ticket_count_badge(camp_tickets)
    owned_tickets = camp_tickets.owned
    return na_badge unless owned_tickets.present?
    success_count_badge(owned_tickets.size)
  end
end