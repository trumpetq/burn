class FixSkippedAt < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_interviews, :skipped_at
    add_column :camp_interviews, :skipped_at, :datetime, null: true
  end
end
