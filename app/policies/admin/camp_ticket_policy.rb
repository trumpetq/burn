module Admin
  class CampTicketPolicy < Admin::CampPolicy
    def permitted_attributes
      [:availability, :confirmation_id,  :location, :notes, :private_notes, :sale, :status, :ticket_type, :user_id]
    end
  end
end
