class FixDues3 < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :transaction_id, :string, null: false
    add_column :camp_deposits, :transaction_id, :string, null: false
  end
end
