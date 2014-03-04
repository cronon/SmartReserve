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

ActiveRecord::Schema.define(version: 20140304142238) do

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tables_count"
    t.text     "description"
    t.integer  "average_time", limit: 255
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
  end

  create_table "orders", force: true do |t|
    t.integer  "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "time"
    t.datetime "since"
    t.datetime "until"
  end

  add_index "orders", ["table_id"], name: "index_orders_on_table_id"

  create_table "tables", force: true do |t|
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_now", default: "free"
  end

  add_index "tables", ["club_id"], name: "index_tables_on_club_id"

end
