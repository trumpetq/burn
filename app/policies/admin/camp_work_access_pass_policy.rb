module Admin
  class CampWorkAccessPassPolicy < Admin::CampPolicy
    def assign?
      mayor?
    end

    def remove_ticket?
      mayor?
    end

    def permitted_attributes
      [:approval_required, :expected_arrival_on, :notes, :pass_on, :private_notes, :status, :ticket, :ticket_id, :user_id]
    end
  end
end
