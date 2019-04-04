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

ActiveRecord::Schema.define(version: 2019_01_18_055836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "card_faces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "artist"
    t.string "color_indicator", default: [], array: true
    t.string "colors", default: [], array: true
    t.string "flavor_text"
    t.uuid "illustration_id"
    t.json "image_uris", default: {}, null: false
    t.string "loyalty"
    t.string "mana_cost"
    t.string "name"
    t.string "object"
    t.string "oracle_text"
    t.string "power"
    t.string "printed_name"
    t.string "printed_text"
    t.string "printed_type_line"
    t.string "toughness"
    t.string "type_line"
    t.uuid "magic_card_id"
    t.string "watermark"
  end

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
  

  create_table "magic_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "supertypes", default: [], array: true
    t.string "types", default: [], array: true
    t.string "subtypes", default: [], array: true
    t.string "other_names", default: [], array: true
    t.string "variations", default: [], array: true
    t.string "original_text"
    t.string "original_type"
    t.json "rulings", default: [], null: false, array: true
    t.string "arena_id"
    t.uuid "scryfall_id"
    t.string "lang"
    t.string "mtgo_id"
    t.string "mtgo_foil_id"
    t.string "multiverse_ids", default: [], array: true
    t.string "tcgplayer_id"
    t.string "object"
    t.uuid "oracle_id"
    t.string "prints_search_uri"
    t.string "rulings_uri"
    t.string "scryfall_uri"
    t.string "uri"
    t.decimal "cmc"
    t.string "colors", default: [], array: true
    t.string "color_identity", default: [], array: true
    t.string "color_indicator", default: [], array: true
    t.integer "edhrec_rank"
    t.boolean "foil"
    t.string "hand_modifier"
    t.string "layout"
    t.json "legalities", default: {}, null: false
    t.string "life_modifier"
    t.string "loyalty"
    t.string "mana_cost"
    t.string "name"
    t.boolean "nonfoil"
    t.string "oracle_text"
    t.boolean "oversized"
    t.string "power"
    t.boolean "reserved"
    t.string "toughness"
    t.string "type_line"
    t.string "artist"
    t.string "border_color"
    t.string "collector_number"
    t.boolean "digital"
    t.string "flavor_text"
    t.string "frame"
    t.string "frame_effect"
    t.boolean "full_art"
    t.string "games", default: [], array: true
    t.boolean "hires_image"
    t.uuid "illustration_id"
    t.json "image_uris", default: {}, null: false
    t.string "printed_name"
    t.string "printed_text"
    t.string "printed_type_line"
    t.boolean "promo"
    t.json "purchase_uris", default: {}, null: false
    t.string "rarity"
    t.json "related_uris"
    t.string "released_at"
    t.boolean "reprint"
    t.string "scryfall_set_uri"
    t.string "set"
    t.string "set_name"
    t.string "set_search_uri"
    t.string "set_uri"
    t.boolean "story_spotlight"
    t.string "watermark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "scryfall_id"
    t.string "object"
    t.string "component"
    t.string "name"
    t.string "type_line"
    t.string "uri"
    t.uuid "magic_card_id"
  end

  create_table "user_cards", force: :cascade do |t|
    t.integer "user_id"
    t.string "quality"
    t.string "value"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "magic_card_id"
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
