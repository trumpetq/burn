class BigJobsChange < ActiveRecord::Migration[7.0]
  def change
    drop_table :camp_jobs
    rename_table :camp_job_definitions, :camp_jobs

    add_column :camp_jobs, :approved_at, :datetime, null: true
    add_column :camp_jobs, :completed_at, :datetime, null: true
    add_column :camp_jobs, :rejected_at, :datetime, null: true
    add_column :camp_jobs, :approved_by_id, :bigint, null: true
    add_column :camp_jobs, :completed_by_id, :bigint, null: true
    add_column :camp_jobs, :rejected_by_id, :bigint, null: true
  end
end
