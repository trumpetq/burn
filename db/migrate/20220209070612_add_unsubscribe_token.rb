class AddUnsubscribeToken < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :unsubscribe_token, :string, null: false, index: true
  end
end
