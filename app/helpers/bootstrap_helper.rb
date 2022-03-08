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
end
