class ChangePointsColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :camp_job_definitions, :points, :decimal, precision: 5, scale: 2
  end
end
