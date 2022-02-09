module TimeHelper
  def admin_time(time)
    return na_badge if time.blank?

    if current_user
      time.in_time_zone(current_user.time_zone).to_fs(:admin)
    else
      time.to_fs(:admin)
    end
  end

  def admin_date(date)
    return na_badge if date.blank?
    date.to_fs(:year_month_day)
  end

  def event_date(date)
    return na_badge if date.blank?

    found = Settings.date.full_event.find { _1[1] == date.to_fs(:year_month_day)}

    if found
      found[0]
    else
      admin_date(date)
    end
  end
end