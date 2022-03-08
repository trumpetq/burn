class TestNull < ActiveRecord::Migration[7.0]
  def change
    change_column(:camp_interviews, :status, :integer, null: false, default: nil)
    change_column(:camp_applications, :status, :integer, null: false, default: nil)
  end
end
