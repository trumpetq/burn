class AddDescription < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_descriptions, :description, :text, null: false
  end
end
