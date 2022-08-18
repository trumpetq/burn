module BootstrapHelper
  COLORS = [:primary, :secondary, :success, :danger, :warning, :info, :light, :dark]
  def bootstrap_flash_class(flash_type)
    case flash_type.to_sym
    when :alert then "alert-danger"
    when :notice then "alert-info"
    when :success then "alert-success"
    when :warning then "alert-warning"
    else
      "alert-dark"
    end
  end

  def bootstrap_icon(name, class_name: nil)
    tag.i(class: "bi-#{name} #{class_name}".strip)
  end

  def active_if(name)
    name.to_sym == action_name.to_sym ? "active" : nil
  end

  COLORS.each do |color|
    define_method("#{color}_count_badge") do |count, class_name: nil, tooltip: nil|
      if tooltip.present?
        count_badge(count, class_name: "badge rounded-pill bg-#{color} #{class_name}".strip, tooltip: tooltip)
      else
        count_badge(count, class_name: "badge rounded-pill bg-#{color} #{class_name}".strip)
      end
    end
  end

  COLORS.each do |color|
    define_method("#{color}_badge") { |text, class_name: nil| tag.span(text, class: "badge text-bg-#{color} #{class_name}".strip) }
  end
end
