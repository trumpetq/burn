class FixRejected < ActiveRecord::Migration[7.0]
  def change
    remove_column :camp_applications, :rejected_by_id
    add_column :camp_applications, :rejected_by_id, :bigint, null: true
  end
end
