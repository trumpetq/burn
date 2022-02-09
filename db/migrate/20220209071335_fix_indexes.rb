class FixIndexes < ActiveRecord::Migration[7.0]
  def change
    remove_index :newsletters, :user_id

    add_index :newsletters, :user_id, unique: true
    add_index :newsletters, :email, unique: true
    add_index :newsletters, :unsubscribe_token, unique: true
  end
end
