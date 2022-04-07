class FixCampTickets < ActiveRecord::Migration[7.0]
  def change
    rename_column :camp_tickets, :type, :ticket_type
  end
end
