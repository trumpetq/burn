class AddCampDescriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_definitions, :camp_job_description_id, :bigint, null: true
    remove_column :camp_jobs, :begin_at, :datetime
    remove_column :camp_jobs, :end_at, :datetime
    remove_column :camp_jobs, :job_on, :date

    add_column :camp_job_definitions, :begin_at, :datetime, null: true
    add_column :camp_job_definitions, :end_at, :datetime, null: true
    add_column :camp_job_definitions, :job_on, :date, null: true

    create_table :camp_job_descriptions do |t|
      t.text :description, null: true
      t.timestamps
    end
  end
end
