class AddTiktokToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tiktok_url, :text, null: true
  end
end
