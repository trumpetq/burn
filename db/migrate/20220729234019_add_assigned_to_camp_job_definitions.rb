class AddAssignedToCampJobDefinitions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_definitions, :assigned_at, :datetime, null: true
    add_column :camp_job_definitions, :assigned_by_id, :bigint, null: true
  end
end
