class Fix4 < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :paid_by_id, :bigint, null: true
    add_column :camp_deposits, :paid_by_id, :bigint, null: true
  end
end
