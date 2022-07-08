class AddTrailerType < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_vehicles, :trailer_type, :integer, null: true
  end
end
