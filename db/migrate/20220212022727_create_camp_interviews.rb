class CreateCampInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_interviews do |t|
      t.integer :status, null: false, default: 0
      t.references :user, index: true
      t.datetime :applied_at, null: true
      t.datetime :completed_at, null: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.bigint :interviewed_by_id, null: true
      t.datetime :assigned_at, null: true
      t.bigint :skipped_at, null: true
      t.text :initial_notes, null: true
      t.text :feedback_notes, null: true
      t.text :private_notes, null: true
      t.datetime :rejected_at
      t.bigint :rejected_by_id, null: true
      t.timestamps
    end

    add_column :camp_applications, :rejected_at, :datetime, null: true
    add_column :camp_applications, :rejected_by_id, :datetime, null: true
  end
end
