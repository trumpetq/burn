class AddJobIdToCampJobDefinitions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_definitions, :job_id, :string, null: true
  end
end
