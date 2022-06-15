class UpdateDuesAndDeposits < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :refunded_at, :datetime, null: true
    add_column :camp_dues, :refunded_by_id, :bigint, null: true
    add_column :camp_deposits, :refunded_at, :datetime, null: true
    add_column :camp_deposits, :refunded_by_id, :bigint, null: true
  end
end
