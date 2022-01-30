module TimeHelper
  def admin_time(resource)
    return na_badge if resource.blank?

    if current_user
      resource.in_time_zone(current_user.time_zone).to_s(:admin)
    else
      resource.to_s(:admin)
    end
  end
end