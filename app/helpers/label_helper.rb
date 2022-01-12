module LabelHelper
  def na_label
    tag.span("N/A", class: "badge bg-light text-dark")
  end

  def no_label(label_text = nil)
    yes_or_no_label(false, label_text)
  end

  def yes_label(label_text = nil)
    yes_or_no_label(true, label_text)
  end

  def yes_or_no_label(value, label_text = nil)
    if value
      tag.span(label_text.presence || "Yes", class: "badge bg-success")
    else
      tag.span(label_text.presence || "No", class: "badge bg-danger")
    end
  end

  def rails_environment_label
    css_class =
      case Rails.env.to_sym
      when :development then "badge bg-success"
      when :production then "badge bg-danger"
      when :staging then "badge bg-warning text-dark"
      else
        "badge bg-dark"
      end

    tag.span(Rails.env.titleize, class: css_class)
  end
end
