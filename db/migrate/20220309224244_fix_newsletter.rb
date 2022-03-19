class FixNewsletter < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:newsletters, :list, from: 0, to: nil)
    change_column_default(:users, :role, from: 0, to: nil)
    change_column_default(:users, :status, from: 0, to: nil)
    change_column_default(:users, :plan, from: 0, to: nil)
  end
end
