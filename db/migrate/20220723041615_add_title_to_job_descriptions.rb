class AddTitleToJobDescriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_descriptions, :title, :text, null: false
    change_column :camp_job_definitions, :title, :text, null: false
  end
end
