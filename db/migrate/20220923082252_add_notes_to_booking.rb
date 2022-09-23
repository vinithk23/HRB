class AddNotesToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :notes, :text, null: true
  end
end
