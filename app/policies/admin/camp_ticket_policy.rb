module Admin
  class CampTicketPolicy < Admin::CampPolicy
    def permitted_attributes
      [:availability, :location, :notes, :sale, :status, :ticket_type, :confirmation_id, :user_id]
    end
  end
end
