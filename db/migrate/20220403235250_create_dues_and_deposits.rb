class CreateDuesAndDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_dues do |t|
      t.integer :status, null: false
      t.references :user, index: true
      t.datetime :paid_at, null: true
      t.datetime :completed_at, null: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.text :private_notes, null: true
      t.datetime :rejected_at
      t.bigint :rejected_by_id, null: true
      t.monetize :price
      t.timestamps
    end

    create_table :camp_deposits do |t|
      t.integer :status, null: false
      t.references :user, index: true
      t.datetime :paid_at, null: true
      t.datetime :completed_at, null: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.text :private_notes, null: true
      t.datetime :rejected_at
      t.bigint :rejected_by_id, null: true
      t.monetize :price
      t.timestamps
    end
  end
end
