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

ActiveRecord::Schema.define(version: 20140525103554) do

  create_table "abouts", force: true do |t|
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "bottom_links", force: true do |t|
    t.string   "src"
    t.integer  "category_link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "category_links", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tables_count"
    t.text     "description"
    t.string   "mon_opens",                                 default: "08:00"
    t.string   "mon_closes",                                default: "23:00"
    t.string   "tue_opens",                                 default: "08:00"
    t.string   "tue_closes",                                default: "23:00"
    t.string   "wed_opens",                                 default: "08:00"
    t.string   "wed_closes",                                default: "23:00"
    t.string   "thu_opens",                                 default: "08:00"
    t.string   "thu_closes",                                default: "23:00"
    t.string   "fri_opens",                                 default: "08:00"
    t.string   "fri_closes",                                default: "23:00"
    t.string   "sat_opens",                                 default: "08:00"
    t.string   "sat_closes",                                default: "23:00"
    t.string   "sun_opens",                                 default: "08:00"
    t.string   "sun_closes",                                default: "23:00"
    t.integer  "user_id"
    t.string   "phone"
    t.string   "address"
    t.integer  "time_before"
    t.integer  "time_after"
    t.integer  "time_waiting"
    t.string   "time_last"
    t.string   "avatar"
    t.integer  "average_price"
    t.string   "city"
    t.decimal  "rating_average",    precision: 6, scale: 2, default: 0.0
    t.boolean  "is_certified",                              default: false
    t.string   "metro_station"
    t.string   "site"
    t.string   "email"
    t.string   "additional_phones"
    t.string   "payment_methods"
  end

  add_index "clubs", ["user_id"], name: "index_clubs_on_user_id"

  create_table "clubs_properties", id: false, force: true do |t|
    t.integer "club_id",     null: false
    t.integer "property_id", null: false
  end

  add_index "clubs_properties", ["club_id"], name: "index_clubs_properties_on_club_id"
  add_index "clubs_properties", ["property_id"], name: "index_clubs_properties_on_property_id"

  create_table "comments", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.integer  "user_id"
  end

  add_index "comments", ["club_id"], name: "index_comments_on_club_id"

  create_table "favorites", force: true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.integer  "club_id"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "news", ["club_id"], name: "index_news_on_club_id"

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
    t.text     "comment"
  end

  add_index "orders", ["table_id"], name: "index_orders_on_table_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

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

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id"

  create_table "subscribes", force: true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: true do |t|
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_now", default: "free"
    t.integer  "number"
    t.integer  "seats"
    t.string   "hall",       default: "Некурящий"
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
    t.string   "locale"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
