class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :room_no, unique: true, null: false
      t.belongs_to :categories
      t.string :status, null: false, default: "Available"

      t.timestamps
    end
  end
end
