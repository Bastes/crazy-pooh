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

ActiveRecord::Schema.define(:version => 20110531184549) do

  create_table "achievements", :force => true do |t|
    t.string   "section"
    t.string   "subsection"
    t.string   "title"
    t.text     "description"
    t.string   "exhibit_file_name"
    t.string   "exhibit_content_type"
    t.integer  "exhibit_file_size"
    t.datetime "exhibit_updated_at"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["created_at"], :name => "index_achievements_on_created_at"
  add_index "achievements", ["section"], :name => "index_achievements_on_section"
  add_index "achievements", ["subsection"], :name => "index_achievements_on_subsection"

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "phone"
    t.text     "email"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_links", :force => true do |t|
    t.string   "section"
    t.integer  "rank"
    t.string   "label"
    t.text     "description"
    t.text     "url"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_links", ["rank"], :name => "index_external_links_on_rank"
  add_index "external_links", ["section"], :name => "index_external_links_on_section"

  create_table "resumes", :force => true do |t|
    t.string   "label"
    t.string   "exhibit_file_name"
    t.string   "exhibit_content_type"
    t.integer  "exhibit_file_size"
    t.datetime "exhibit_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "static_contents", :force => true do |t|
    t.string "codename"
    t.text   "content"
  end

  add_index "static_contents", ["codename"], :name => "index_static_contents_on_codename"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
