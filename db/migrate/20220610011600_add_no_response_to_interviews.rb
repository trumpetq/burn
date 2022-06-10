class AddNoResponseToInterviews < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_interviews, :no_response_by_id, :bigint, null: true
    add_column :camp_interviews, :no_response_at, :datetime, null: true
  end
end
