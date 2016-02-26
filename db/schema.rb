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

ActiveRecord::Schema.define(version: 20160124072848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
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

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "authentication_tokens", force: :cascade do |t|
    t.string   "auth_token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "bookable_id"
    t.string   "bookable_type"
    t.integer  "quantity",        default: 0,     null: false
    t.date     "date_of_journey"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "from_location"
    t.string   "to_location"
    t.integer  "user_id"
    t.string   "aircraft_type"
    t.boolean  "trip_type",       default: false
    t.boolean  "oneway_trip",     default: false
    t.integer  "item_id"
    t.string   "message"
    t.string   "invoice_number"
    t.string   "tripdate"
    t.string   "triptime"
  end

  add_index "bookings", ["bookable_type", "bookable_id"], name: "index_bookings_on_bookable_type_and_bookable_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.boolean  "domestic"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "mobile"
    t.text     "message"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "mtype"
  end

  create_table "emptylegs", force: :cascade do |t|
    t.string   "aircraft_type"
    t.string   "departon"
    t.string   "from"
    t.string   "to"
    t.integer  "seats"
    t.decimal  "price"
    t.decimal  "min_price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "invoice_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.string   "name",               default: "", null: false
    t.integer  "parent_category_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "display_name"
  end

  create_table "item_specifications", force: :cascade do |t|
    t.integer  "specification_category_id"
    t.string   "skey"
    t.string   "svalue"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "item_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "item_category_id"
    t.string   "name",                      default: "",  null: false
    t.string   "description"
    t.float    "price"
    t.float    "variant_price",             default: 0.0, null: false
    t.float    "discount",                  default: 0.0, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "item_categories_id"
    t.integer  "specification_category_id"
    t.time     "deleted_at"
  end

  add_index "items", ["item_categories_id"], name: "index_items_on_item_categories_id", using: :btree
  add_index "items", ["specification_category_id"], name: "index_items_on_specification_category_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "airport_location"
    t.string   "airport_name"
    t.string   "domestic"
    t.string   "region"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shopping_cart_id"
    t.float    "amount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_thumbnail"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "planes", force: :cascade do |t|
    t.string   "category",            null: false
    t.integer  "passenger_capacity"
    t.integer  "crew"
    t.integer  "range"
    t.integer  "full_pay_load_speed"
    t.string   "base"
    t.integer  "service_sealing"
    t.string   "cabin_dimensions"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "gender"
    t.string   "mobile_number"
    t.string   "location"
    t.string   "shipping_address"
    t.string   "billing_address"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "shopping_cart_items", force: :cascade do |t|
    t.string  "status"
    t.integer "owner_id"
    t.string  "owner_type"
    t.integer "quantity"
    t.integer "item_id"
    t.string  "item_type"
    t.float   "price"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "specification_categories", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "mobile_number"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "facebook_token"
    t.string   "g_token"
    t.string   "device_token"
    t.string   "device_type"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "items", "item_categories"
  add_foreign_key "items", "specification_categories"
end
