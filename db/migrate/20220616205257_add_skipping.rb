class AddSkipping < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :skipped_at, :datetime, null: true
    add_column :camp_dues, :skipped_by_id, :bigint, null: true
    add_column :camp_deposits, :skipped_at, :datetime, null: true
    add_column :camp_deposits, :skipped_by_id, :bigint, null: true
  end
end
