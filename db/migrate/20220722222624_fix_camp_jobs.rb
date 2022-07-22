class FixCampJobs < ActiveRecord::Migration[7.0]
  def change
    change_column :camp_jobs, :user_id, :bigint, null: false
    change_column :camp_job_definitions, :user_id, :bigint, null: false

    add_column :camp_jobs, :camp_job_definition_id, :bigint, index: true, null: false

  end
end
