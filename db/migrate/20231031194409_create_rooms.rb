class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :size
      t.string :guest
      t.decimal :daily_rate, precision: 8, scale: 2
      t.integer :balcony
      t.integer :air_conditioner
      t.integer :tv
      t.integer :wardrobe
      t.integer :safe
      t.integer :accessible
      t.integer :available

      t.timestamps
    end
  end
end
