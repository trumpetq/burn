class AddToSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :description, :text, null: true
    add_column :steps, :available_at, :datetime, null: true
  end
end
