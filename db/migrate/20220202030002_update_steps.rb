class UpdateSteps < ActiveRecord::Migration[7.0]
  def change
    rename_column :steps, :state_enum, :status_enum
  end
end
