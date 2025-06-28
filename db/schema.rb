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

ActiveRecord::Schema[7.2].define(version: 2025_06_28_135335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "default_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expiration_items", force: :cascade do |t|
    t.bigint "recipet_item_id", null: false
    t.integer "quantity"
    t.date "expires_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipet_item_id"], name: "index_expiration_items_on_recipet_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "recipet_items", force: :cascade do |t|
    t.bigint "recipet_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expired_at"
    t.index ["item_id"], name: "index_recipet_items_on_item_id"
    t.index ["recipet_id"], name: "index_recipet_items_on_recipet_id"
  end

  create_table "recipets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "purchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "expiration_items", "recipet_items"
  add_foreign_key "items", "categories"
  add_foreign_key "recipet_items", "items"
  add_foreign_key "recipet_items", "recipets"
  add_foreign_key "recipets", "users"
end
