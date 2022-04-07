class CampTicketPolicy < CampPolicy
  def permitted_attributes
    [:availability, :location, :notes, :sale, :status, :ticket_type, :confirmation_id]
  end
end
