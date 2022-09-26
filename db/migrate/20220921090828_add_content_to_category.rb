class AddContentToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :content, :text, null: false
  end
end