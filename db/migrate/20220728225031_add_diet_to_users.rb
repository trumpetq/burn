class AddDietToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :diet, :integer, null: true
    add_column :users, :allergies, :text, null: true
    add_column :users, :born_on, :date, null: true
  end
end
