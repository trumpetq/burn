class AddNotesToJobDefinitions < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_definitions, :notes, :text, null: true
  end
end
