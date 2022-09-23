class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, unique: true, null: false
      t.text :feature_ids, array: true, default: []
      t.integer :amount, null: false, default: 0

      t.timestamps
    end
  end
end
