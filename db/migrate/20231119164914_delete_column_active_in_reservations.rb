class DeleteColumnActiveInReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :active
  end
end
