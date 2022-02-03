class AddPositionToSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :position, :integer
    add_column :user_steps, :position, :integer
  end
end
