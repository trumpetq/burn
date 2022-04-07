class FixDues2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_dues, :approved_at
    remove_column :camp_deposits, :approved_at
  end
end
