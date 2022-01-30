class RenameStateToStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :state_enum, :status_enum
  end
end
