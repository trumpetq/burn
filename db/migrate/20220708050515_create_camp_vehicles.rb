class CreateCampVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_vehicles do |t|
      t.bigint :completed_by_id
      t.datetime :completed_at
      t.datetime :approved_at
      t.bigint :approved_by_id
      t.bigint :user_id, index: true
      t.integer :status, null: false
      t.datetime :rejected_at
      t.bigint :rejected_by_id
      t.integer :vehicle
      t.string :licence_plate
      t.text :notes
      t.text :private_notes
      t.boolean :sleeping
      t.timestamps
    end
  end
end
