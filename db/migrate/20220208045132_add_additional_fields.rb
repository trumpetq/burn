class AddAdditionalFields < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pronouns, :integer, null: true
    add_column :camp_applications, :burning_man_year_count, :integer, null: true
  end
end
