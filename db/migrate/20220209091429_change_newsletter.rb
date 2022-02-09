class ChangeNewsletter < ActiveRecord::Migration[7.0]
  def change
    remove_column :newsletters, :unsubscribed_at
    add_column :newsletters, :unsubscribed_at, :datetime, null: true
  end
end
