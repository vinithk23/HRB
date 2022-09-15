class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :room
      t.date :in_date, null: false
      t.date :out_date, null: false
      t.integer :adult_count, null: false, default: 0
      t.integer :child_count, null: false, default: 0
      t.integer :adult_cost, null: false, default: 0
      t.integer :child_cost, null: false, default: 0
      t.integer :total_cost, null: false, default: 0

      t.timestamps
    end
  end
end
