class FixDates < ActiveRecord::Migration[7.0]
  def change
    rename_column :camp_applications, :arrival_date, :arrival_on
    rename_column :camp_applications, :departure_date, :departure_on
  end
end
