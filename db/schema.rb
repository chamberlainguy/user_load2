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

ActiveRecord::Schema.define(version: 20151031073253) do

  create_table "users", force: :cascade do |t|
    t.string   "email_address",                                                         default: "", null: false
    t.string   "first_name",                                                            default: "", null: false
    t.string   "last_name",                                                             default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "#<ActiveRecord::ConnectionAdapters::TableDefinition:0x007fd162c97288>"
  end

  add_index "users", ["email_address"], name: "index_users_on_email_address", unique: true

end
