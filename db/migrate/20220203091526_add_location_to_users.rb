class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :country_code, :string, null: true
    add_column :users, :postal_code, :string, null: true
  end
end
