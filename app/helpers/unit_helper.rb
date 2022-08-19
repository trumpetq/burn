module UnitHelper
  def in_feet(number)
    return na_badge if number.nil?

    "#{number} ft"
  end

  def size_in_feet(resource)
    return na_badge if resource.length.blank? && resource.width.blank?

    "#{in_feet(resource.length.to_f)} x #{in_feet(resource.width.to_f)}"
  end
end
