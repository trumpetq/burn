class WapRequired < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_jobs, :wap_required, :boolean, null: true
  end
end
