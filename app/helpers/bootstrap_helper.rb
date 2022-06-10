module BootstrapHelper
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

  def bootstrap_icon(name)
    tag.i(class: "bi-#{name}")
  end

  def active_if(name)
    name.to_sym == action_name.to_sym ? "active" : nil
  end

  def primary_badge(text = nil)
    tag.span(text, class: "badge text-bg-primary")
  end

  def secondary_badge(text = nil)
    tag.span(text, class: "badge text-bg-secondary")
  end

  def success_badge(text = nil)
    tag.span(text, class: "badge text-bg-success")
  end

  def danger_badge(text = nil)
    tag.span(text, class: "badge text-bg-danger")
  end

  def warning_badge(text = nil)
    tag.span(text, class: "badge text-bg-warning")
  end

  def info_badge(text = nil)
    tag.span(text, class: "badge text-bg-info")
  end

  def light_badge(text = nil)
    tag.span(text, class: "badge text-bg-light")
  end

  def dark_badge(text = nil)
    tag.span(text, class:"badge text-bg-dark")
  end
end