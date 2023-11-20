class AddPaymentToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :payment, :string
  end
end
