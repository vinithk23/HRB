class CreateBookingDates < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_dates do |t|
      
      t.date :date, null: false
      t.belongs_to :booking
      t.belongs_to :room

      t.timestamps
    end
  end
end
