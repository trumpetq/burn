class CreateHousing < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_structures do |t|
      t.bigint :user_id, null: true, index: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.datetime :assigned_at, null: true
      t.bigint :assigned_by_id, null: true
      t.datetime :completed_at, null: true
      t.bigint :completed_by_id, null: true
      t.integer :status, null: false
      t.datetime :rejected_at, null: true
      t.bigint :rejected_by_id, null: true
      t.text :description, null: true
      t.text :notes, null: true
      t.text :private_notes, null: true
      t.integer :structure, null: true
      t.boolean :map, null: true
      t.decimal :length, null: true, precision: 5, scale: 2
      t.decimal :width, null: true, precision: 5, scale: 2
      t.timestamps
    end

    add_column :camp_vehicles, :map, :boolean, null: true
    add_column :camp_vehicles, :length, :decimal, precision: 5, scale: 2, null: true
    add_column :camp_vehicles, :width, :decimal, precision: 5, scale: 2, null: true
  end
end
