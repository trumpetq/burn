class FixWap < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_work_access_passes, :applied_at, :datetime
    add_column :camp_work_access_passes, :assigned_at, :datetime, null: true
    add_column :camp_work_access_passes, :assigned_by_id, :bigint, null: true
  end
end
