class RedesignSteps < ActiveRecord::Migration[7.0]
  def change
    drop_table :steps

    create_table :steps do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.text :description, null: true
      t.integer :status_enum, null: false, default: 0
      t.datetime :available_at, null: true
      t.datetime :closed_at, null: true
      t.timestamps
    end

    create_table :user_steps do |t|
      t.references :user, index: true
      t.references :step, index: true
      t.integer :status_enum, null: false, default: 0
      t.timestamp :completed_at
      t.references :stepable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
