class AddDepartment < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_descriptions, :department, :integer, null: true
  end
end
