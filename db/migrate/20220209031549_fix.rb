class Fix < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :previous_years, :jsonb, null: true
  end
end
