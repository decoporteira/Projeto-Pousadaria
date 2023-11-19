class AddDefaultToStatusInReservations < ActiveRecord::Migration[7.0]
  def change
    change_column_default :reservations, :status, 1
  end
end
