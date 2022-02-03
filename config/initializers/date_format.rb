# https://ruby-doc.org/core-3.1.0/Time.html#method-i-strftime
Date::DATE_FORMATS[:year_month_day] = "%Y-%m-%d"
Time::DATE_FORMATS[:admin] = "%Y-%m-%d at %-l:%M:%S %P %Z"
Time::DATE_FORMATS[:time] = "%-l:%M:%S %P"
Time::DATE_FORMATS[:time_with_time_zone] = "%-l:%M:%S %P %Z"
Time::DATE_FORMATS[:day_with_year] = "%B %-d, %Y"
