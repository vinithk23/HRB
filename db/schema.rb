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

ActiveRecord::Schema[7.0].define(version: 2022_09_15_093805) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "rooms_id"
    t.date "in_date", null: false
    t.date "out_date", null: false
    t.integer "adult_count", default: 0, null: false
    t.integer "child_count", default: 0, null: false
    t.integer "adult_cost", default: 0, null: false
    t.integer "child_cost", default: 0, null: false
    t.integer "total_cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rooms_id"], name: "index_bookings_on_rooms_id"
    t.index ["users_id"], name: "index_bookings_on_users_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "feature_ids", default: [], array: true
    t.integer "user_cost", default: 0, null: false
    t.integer "guest_cost", default: 0, null: false
    t.integer "child_cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "room_no", null: false
    t.bigint "categories_id"
    t.string "status", default: "Available", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_rooms_on_categories_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.bigint "phone", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "roles_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["roles_id"], name: "index_users_on_roles_id"
  end

end
