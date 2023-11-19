class ChangeStatusTypeToIntegerInReservations < ActiveRecord::Migration[7.0]
  def change
    change_column :reservations, :status, :integer
  end
end
