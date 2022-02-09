class CreateNewsletter < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletters do |t|
      t.string :email
      t.integer :list, default: 0, null: false
      t.boolean :unsubscribed_at
      t.references :user, null: true, index: true
      t.timestamps
    end

    add_column :camp_applications, :approved_at, :datetime, null: true
    add_column :camp_applications, :approved_by_id, :bigint, null: true
  end
end
