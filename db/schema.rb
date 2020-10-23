# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_23_005334) do

  create_table "addresses", force: :cascade do |t|
    t.string "requester_zip_code"
    t.string "state"
    t.string "city"
    t.string "street"
    t.string "number"
    t.integer "requester_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requester_id"], name: "index_addresses_on_requester_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.integer "requester_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requester_id"], name: "index_phones_on_requester_id"
  end

  create_table "requesters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cnpj", null: false
    t.string "company_name", null: false
    t.index ["email"], name: "index_requesters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_requesters_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "requesters"
  add_foreign_key "phones", "requesters"
end
