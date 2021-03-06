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

ActiveRecord::Schema.define(version: 2020_10_23_211959) do

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

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "credits", force: :cascade do |t|
    t.decimal "parcel", precision: 10, scale: 12, default: "0.0", null: false
    t.decimal "tax", precision: 10, scale: 12, null: false
    t.integer "periods", null: false
    t.boolean "already_accepted", default: false, null: false
    t.decimal "loan", precision: 10, scale: 12, null: false
    t.integer "requester_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requester_id"], name: "index_credits_on_requester_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.integer "position", null: false
    t.decimal "value", precision: 10, scale: 12, null: false
    t.date "expiring_date", null: false
    t.boolean "paid", default: false, null: false
    t.integer "credit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["credit_id"], name: "index_parcels_on_credit_id"
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
    t.index ["cnpj"], name: "index_requesters_on_cnpj", unique: true
    t.index ["company_name"], name: "index_requesters_on_company_name", unique: true
    t.index ["email"], name: "index_requesters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_requesters_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "requesters"
  add_foreign_key "credits", "requesters"
  add_foreign_key "parcels", "credits"
  add_foreign_key "phones", "requesters"
end
