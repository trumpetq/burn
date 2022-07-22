class CreateCampJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_jobs do |t|
      t.integer :status, null: false
      t.references :user, index: true
      t.datetime :assigned_at, null: true
      t.bigint :assigned_by_id, null: true
      t.datetime :completed_at, null: true
      t.bigint :completed_by_id, null: true
      t.datetime :approved_at, null: true
      t.bigint :approved_by_id, null: true
      t.text :private_notes, null: true
      t.text :notes, null: true
      t.datetime :rejected_at, null: true
      t.bigint :rejected_by_id, null: true
      t.date :job_on, null: true
      t.datetime :begin_at, null: true
      t.datetime :end_at, null: true
      t.timestamps
    end

    create_table :camp_job_definitions do |t|
      t.references :user, index: true
      t.integer :status, null: false
      t.integer :timeframe, null: false
      t.text :private_notes, null: true
      t.text :description
      t.text :title
      t.boolean :all_day, null: true
      t.boolean :east_bay, null: true
      t.boolean :strong_person, null: true
      t.boolean :approval_required, null: true
      t.decimal :points, precision: 4, scale: 2
      t.timestamps
    end
  end
end
