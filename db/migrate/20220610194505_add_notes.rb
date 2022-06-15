class AddNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :notes, :text, null: true
    add_column :camp_deposits, :notes, :text, null: true
  end
end
