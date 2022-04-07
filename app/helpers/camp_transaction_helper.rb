module CampTransactionHelper
  def camp_payment_method_badge(camp)
    return na_badge unless camp&.payment_method.present?

    css_class =
      case camp.payment_method.to_sym
      when :cash then "badge bg-secondary"
      when :paypal then "badge bg-primary"
      when :venmo then "badge bg-success"
      when :other then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.payment_method&.to_s&.humanize, class: css_class)
  end

  def camp_price_tier_badge(camp)
    return na_badge unless camp&.price_tier.present?

    css_class =
      case camp.price_tier.to_sym
      when :low_income then "badge bg-warning"
      when :middle_income then "badge bg-primary"
      when :startup then "badge bg-success"
      when :baller then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.price_tier&.to_s&.humanize, class: css_class)
  end
end