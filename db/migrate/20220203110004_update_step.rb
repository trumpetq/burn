class UpdateStep < ActiveRecord::Migration[7.0]
  def change
    rename_column :steps, :type, :step_type
  end
end
