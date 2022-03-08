class AddMoreIds < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_interviews, :assigned_by_id, :bigint, null: true
    add_column :camp_interviews, :skipped_by_id, :bigint, null: true
  end
end
