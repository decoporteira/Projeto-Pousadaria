class AddCheckOutDateAndTimeToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :check_out_date, :date
    add_column :reservations, :check_out_time, :time
  end
end
