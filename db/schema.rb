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

ActiveRecord::Schema.define(version: 20140330175321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tables_count"
    t.text     "description"
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
    t.integer  "user_id"
    t.string   "phone"
    t.string   "adress"
    t.integer  "time_before"
    t.integer  "time_after"
    t.integer  "time_waiting"
    t.string   "time_last"
    t.string   "avatar"
  end

  add_index "clubs", ["user_id"], name: "index_clubs_on_user_id", using: :btree

  create_table "clubs_properties", id: false, force: true do |t|
    t.integer "club_id",     null: false
    t.integer "property_id", null: false
  end

  add_index "clubs_properties", ["club_id"], name: "index_clubs_properties_on_club_id", using: :btree
  add_index "clubs_properties", ["property_id"], name: "index_clubs_properties_on_property_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.integer  "user_id"
  end

  add_index "comments", ["club_id"], name: "index_comments_on_club_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "table_id"
    t.datetime "since"
    t.datetime "until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "name"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "time"
    t.string   "confirmation"
  end

  add_index "orders", ["table_id"], name: "index_orders_on_table_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.string   "image"
  end

  add_index "photos", ["club_id"], name: "index_photos_on_club_id", using: :btree

  create_table "properties", force: true do |t|
    t.string "name_ru"
    t.string "name_en"
    t.string "kind_ru"
    t.string "kind_en"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "tables", force: true do |t|
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_now", default: "free"
  end

  add_index "tables", ["club_id"], name: "index_tables_on_club_id", using: :btree

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
