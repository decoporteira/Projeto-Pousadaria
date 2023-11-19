class AddCheckInDateAndTimeToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :check_in_date, :date
    add_column :reservations, :check_in_time, :time
  end
end
