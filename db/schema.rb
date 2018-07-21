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

ActiveRecord::Schema.define(version: 2018_07_21_000802) do

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "user_card_id"
    t.integer "side_board_quantity"
    t.integer "main_board_quantity"
    t.boolean "side_board_option"
    t.boolean "main_board_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "format"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_cards", force: :cascade do |t|
    t.string "name"
    t.string "layout"
    t.string "cmc"
    t.string "colors"
    t.string "color_identity"
    t.string "card_type"
    t.string "supertypes"
    t.string "types"
    t.string "subtypes"
    t.string "rarity"
    t.string "set_code"
    t.string "setname"
    t.string "text"
    t.string "flavor"
    t.string "artist"
    t.string "number"
    t.string "power"
    t.string "toughness"
    t.string "loyalty"
    t.string "card_id"
    t.string "multiverse_id"
    t.string "other_names"
    t.string "mana_cost"
    t.string "variations"
    t.string "image_url"
    t.string "watermark"
    t.string "border"
    t.boolean "timeshifted"
    t.string "hand"
    t.string "life"
    t.boolean "reserved"
    t.string "release_date"
    t.boolean "starter"
    t.string "rulings"
    t.string "original_text"
    t.string "original_type"
    t.string "legalities"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_cards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "magic_card_id"
    t.string "quality"
    t.float "value"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "uid"
    t.string "email"
    t.string "image"
    t.integer "dci_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
