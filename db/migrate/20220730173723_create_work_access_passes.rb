class CreateWorkAccessPasses < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_work_access_passes do |t|
      t.integer :status, null: false
      t.datetime :applied_at, null: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.datetime :rejected_at, null: true
      t.bigint :rejected_by_id, null: true
      t.bigint :user_id, null: true, index: true
      t.text :ticket_id, null: true
      t.text :notes, null: true
      t.text :private_notes, null: true
      t.date :pass_on, null: true
      t.date :expected_arrival_on, null: true
      t.timestamps
    end
  end
end
