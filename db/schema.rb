# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140313145024) do

  create_table "club_images", force: true do |t|
    t.string   "image"
    t.string   "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tables_count"
    t.text     "description"
    t.integer  "time_waiting"
    t.integer  "time_before"
    t.integer  "time_after"
    t.string   "time_last"
    t.string   "mon_opens"
    t.string   "mon_closes"
    t.string   "tue_opens"
    t.string   "tue_closes"
    t.string   "wed_opens"
    t.string   "wed_closes"
    t.string   "thu_opens"
    t.string   "thu_closes"
    t.string   "fri_opens"
    t.string   "fri_closes"
    t.string   "sat_opens"
    t.string   "sat_closes"
    t.string   "sun_opens"
    t.string   "sun_closes"
    t.integer  "owner_id"
    t.string   "phone"
    t.string   "adress"
  end

  add_index "clubs", ["owner_id"], name: "index_clubs_on_owner_id"

  create_table "orders", force: true do |t|
    t.integer  "table_id"
    t.datetime "since"
    t.datetime "until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "name"
    t.string   "token"
    t.integer  "user_id", :default => nil
    t.datetime "time"
  end

  add_index "orders", ["table_id"], name: "index_orders_on_table_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.string   "image"
  end

  add_index "photos", ["club_id"], name: "index_photos_on_club_id"

  create_table "tables", force: true do |t|
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_now", default: "free"
  end

  add_index "tables", ["club_id"], name: "index_tables_on_club_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "phone",                                  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "owner_clubs",            default: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
