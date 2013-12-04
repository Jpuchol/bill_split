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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20131203103805) do
=======
ActiveRecord::Schema.define(version: 20131203223926) do

  create_table "bill_users", force: true do |t|
    t.integer  "bill_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
>>>>>>> e35f8515c91ad37df94f4603285e0c2d449fe29e

  create_table "bills", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "comment"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.string   "ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["user_id", "created_at"], name: "index_bills_on_user_id_and_created_at"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["group_id", "user_id"], name: "index_members_on_group_id_and_user_id", unique: true
  add_index "members", ["group_id"], name: "index_members_on_group_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "imag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

end
