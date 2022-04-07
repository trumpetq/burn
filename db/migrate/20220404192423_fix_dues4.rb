class FixDues4 < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_dues, :payment_method, :integer
    add_column :camp_deposits, :payment_method, :integer
    add_column :camp_dues, :price_tier, :integer
    add_column :camp_deposits, :price_tier, :integer
  end
end
