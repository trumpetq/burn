class AddStiToUserSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :user_steps, :type, :string
    add_column :user_steps, :applied_at, :datetime, null: true
    add_column :steps, :type, :string
  end
end
