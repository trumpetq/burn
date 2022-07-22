module CampInterviewHelper
  def camp_interviews_count_badge(count)
    return na_badge unless count.present?

    if count.zero?
      tag.span(number_with_delimiter(count), class: "badge rounded-pill bg-success")
    else
      tag.span(number_with_delimiter(count), class: "badge rounded-pill bg-warning text-dark")
    end
  end
end