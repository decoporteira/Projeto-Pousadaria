class CreateInns < ActiveRecord::Migration[7.0]
  def change
    create_table :inns do |t|
      t.string :trade_name
      t.string :company_name
      t.string :registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :zip_code
      t.text :description
      t.string :payment_methods
      t.integer :is_pets_allowed
      t.text :rules
      t.time :check_in
      t.time :check_out
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
