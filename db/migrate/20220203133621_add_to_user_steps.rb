class AddToUserSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :user_steps, :who_are_you, :text, null: true
    add_column :user_steps, :what_excites_you, :text, null: true
    add_column :user_steps, :referral_name, :string, null: true
  end
end
