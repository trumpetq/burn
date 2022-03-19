class AddTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_tickets do |t|
      t.references :user, null: false, index: true
      t.integer :type, null: false
      t.integer :status, null: false
      t.integer :location, null: false
      t.text :notes, null: true
      t.timestamps
    end
  end
end
