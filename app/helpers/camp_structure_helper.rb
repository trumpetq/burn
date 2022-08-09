module CampStructureHelper
  def camp_structure_badge(camp)
    return na_badge unless camp&.structure.present?

    css_class =
      case camp.structure.to_sym
      when :not_sure then "badge bg-secondary"
      when :tent then "badge bg-success"
      when :carport, :hexayurt then "badge bg-primary"
      when :shiftpod then "badge bg-info"
      when :monkey_hut then "badge badge-warning"
      when :other then "badge bg-danger"
      else
        "badge bg-dark"
      end

    tag.span(camp.structure&.to_s&.humanize, class: css_class)
  end
end
