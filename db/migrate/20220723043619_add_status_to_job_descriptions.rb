class AddStatusToJobDescriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_descriptions, :status, :integer, null: false
    add_column :camp_job_descriptions, :user_id, :bigint, null: true
  end
end
