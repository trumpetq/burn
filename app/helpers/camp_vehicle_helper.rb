module CampVehicleHelper
  def camp_vehicle_badge(camp)
    return na_badge unless camp&.vehicle.present?

    css_class =
      case camp.vehicle.to_sym
      when :no_vehicle then "badge bg-secondary"
      when :car, :suv, :pickup_truck, :van then "badge bg-success"
      when :small_box_truck, :medium_box_truck, :large_box_truck then "badge bg-primary"
      when :small_rv, :medium_rv, :large_rv then "badge bg-info"
      when :school_bus, :airplane then "badge badge-warning"
      when :other then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.vehicle&.to_s&.humanize, class: css_class)
  end

  def camp_trailer_badge(camp)
    return na_badge unless camp&.trailer.present?

    css_class =
      case camp.trailer.to_sym
      when :no_trailer then "badge bg-secondary"
      when :small_trailer then "badge bg-success"
      when :medium_trailer then "badge bg-primary"
      when :large_trailer then "badge bg-danger"
      when :other then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.trailer&.to_s&.humanize, class: css_class)
  end
end