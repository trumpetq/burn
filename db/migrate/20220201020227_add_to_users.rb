class AddToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :description, :text, null: true
    add_column :users, :title, :string, null: true
    add_column :users, :previous_years, :jsonb, default: [], null: false
  end
end
