class AddDiscarded < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at

    add_column :camp_applications, :discarded_at, :datetime
    add_index :camp_applications, :discarded_at

    add_column :camp_interviews, :discarded_at, :datetime
    add_index :camp_interviews, :discarded_at

    add_column :newsletters, :discarded_at, :datetime
    add_index :newsletters, :discarded_at
  end
end
