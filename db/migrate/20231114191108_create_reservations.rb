class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.date :start_date
      t.date :final_date
      t.integer :guest_number
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
