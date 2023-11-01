class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.decimal :new_rate, precision: 8, scale: 2
      t.time :start_date
      t.time :final_date
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
