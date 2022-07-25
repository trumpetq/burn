class FixDescription < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_job_definitions, :description

  end
end
