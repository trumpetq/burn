class FixDues < ActiveRecord::Migration[7.0]
  def change
    rename_column :camp_dues, :approved_by_id, :completed_by_id
    rename_column :camp_deposits, :approved_by_id, :completed_by_id
  end
end
