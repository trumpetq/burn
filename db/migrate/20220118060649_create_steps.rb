class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.string :name, null: false
      t.string :short_description
      t.integer :state_enum, null: false, default: 0
      t.references :user, index: true
      t.timestamp :completed_at
      t.references :stepable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
