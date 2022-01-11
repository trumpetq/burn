module BootstrapHelper
  def bootstrap_flash_class(flash_type)
    case flash_type.to_sym
    when :alert then "alert-danger"
    when :notice then "alert-info"
    when :success then "alert-success"
    when :warning then "alert-warning"
    else "alert-dark"
    end
  end
end
