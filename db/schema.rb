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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121112080119) do

  create_table "connection_types", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "connections", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "connection_type_id"
    t.boolean  "confirmed"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "connections", ["from_id", "to_id"], :name => "index_connections_on_from_id_and_to_id", :unique => true
  add_index "connections", ["from_id"], :name => "index_connections_on_from_id"
  add_index "connections", ["to_id"], :name => "index_connections_on_to_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner_id"
  end

  add_index "events", ["owner_id"], :name => "index_events_on_owner_id"

  create_table "invitees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invites", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "photo_path"
    t.string   "description"
    t.string   "buy_link"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "price_cents"
    t.string   "currency"
  end

  add_index "items", ["user_id", "created_at"], :name => "index_items_on_user_id_and_created_at"

  create_table "user_posts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_posts", ["user_id", "created_at"], :name => "index_user_posts_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "displayed_name"
    t.string   "email"
    t.boolean  "male"
    t.date     "birthday"
    t.boolean  "hide_age"
    t.string   "city"
    t.string   "country"
    t.string   "zip_code"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
