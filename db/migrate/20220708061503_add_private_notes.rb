class AddPrivateNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_tickets, :private_notes, :text, null: true
    add_column :users, :private_notes, :text, null: true
  end
end
