class RemoveTitle < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_job_definitions, :title, :text
    remove_column :camp_job_descriptions, :description, :text
  end
end
