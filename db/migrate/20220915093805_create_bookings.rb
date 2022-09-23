class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :room
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :adult_count, null: false, default: 0
      t.integer :child_count, null: false, default: 0

      t.timestamps
    end
  end
end
