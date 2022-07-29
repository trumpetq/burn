class RenameEastBay < ActiveRecord::Migration[7.0]
  def change
    rename_column :camp_job_definitions, :east_bay, :bay_area
  end
end
