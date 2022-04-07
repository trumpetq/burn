class AddConfirmationIdToCampTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_tickets, :confirmation_id, :string, null: true
    add_column :camp_tickets, :sale, :integer, null: false
    add_column :camp_tickets, :availability, :integer, null: false
  end
end
