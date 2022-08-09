class CampVehiclePolicy < CampPolicy
  def edit?
    member? && me?
  end

  def permitted_attributes
    [:vehicle, :trailer, :licence_plate, :sleeping, :length, :width, :notes]
  end
end
