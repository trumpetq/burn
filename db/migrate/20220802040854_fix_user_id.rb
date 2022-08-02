class FixUserId < ActiveRecord::Migration[7.0]
  def change
    change_column :camp_jobs, :user_id, :bigint, null: true
  end
end
