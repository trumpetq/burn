class AddCompleted < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_applications, :completed_by_id, :bigint, null: true
    add_column :camp_interviews, :completed_by_id, :bigint, null: true
  end
end
