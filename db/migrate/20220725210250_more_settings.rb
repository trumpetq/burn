class MoreSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_job_definitions, :financial, :boolean, null: true
  end
end
