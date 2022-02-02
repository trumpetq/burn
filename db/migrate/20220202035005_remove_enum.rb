class RemoveEnum < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :role_enum, :role
    rename_column :users, :status_enum, :status
    rename_column :steps, :status_enum, :status
    rename_column :user_steps, :status_enum, :status
  end
end
