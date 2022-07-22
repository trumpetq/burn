module CampInterviewHelper
  def camp_interviews_count_badge(count)
    return na_badge unless count.present?

    if count.zero?
      success_count_badge(count)
    else
      warning_count_badge(count)
    end
  end
end