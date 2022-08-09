module UnitHelper
  def in_feet(number)
    return na_badge if number.nil?

    "#{number} ft"
  end
end