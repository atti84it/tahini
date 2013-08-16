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

ActiveRecord::Schema.define(version: 20130816131414) do

  create_table "custom_units", force: true do |t|
    t.string   "singular"
    t.string   "plural"
    t.string   "equivalence_unit"
    t.float    "equivalence_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.float    "number"
    t.string   "unit"
    t.string   "name"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree

  create_table "menu_items", force: true do |t|
    t.integer  "menu_id"
    t.integer  "yields"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id", using: :btree
  add_index "menu_items", ["recipe_id"], name: "index_menu_items_on_recipe_id", using: :btree

  create_table "menus", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.integer  "yields"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ingredients_text"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
