# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_18_134742) do
  create_table "guests", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
    t.index ["reset_password_token"], name: "index_guests_on_reset_password_token", unique: true
  end

  create_table "inns", force: :cascade do |t|
    t.string "trade_name"
    t.string "company_name"
    t.string "registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "zip_code"
    t.text "description"
    t.string "payment_methods"
    t.integer "pet"
    t.text "rules"
    t.time "check_in"
    t.time "check_out"
    t.integer "status"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_inns_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.integer "role"
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "new_rate", precision: 8, scale: 2
    t.date "start_date"
    t.date "final_date"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_prices_on_room_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "room_id", null: false
    t.date "start_date"
    t.date "final_date"
    t.integer "guest_number"
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guest_id", null: false
    t.string "code"
    t.boolean "active", default: true
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "size"
    t.string "guest"
    t.decimal "daily_rate", precision: 8, scale: 2
    t.integer "balcony"
    t.integer "air_conditioner"
    t.integer "tv"
    t.integer "wardrobe"
    t.integer "safe"
    t.integer "accessible"
    t.integer "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inn_id", null: false
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  add_foreign_key "inns", "owners"
  add_foreign_key "prices", "rooms"
  add_foreign_key "reservations", "guests"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "rooms", "inns"
end
