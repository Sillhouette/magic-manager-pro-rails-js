class MagicCardSerializer < ActiveModel::Serializer
  attributes :supertypes, :types, :subtypes, :other_names, :variations, :original_text,
  :original_type, :rulings, :arena_id, :scryfall_id, :lang, :mtgo_id,
  :mtgo_foil_id, :multiverse_ids, :tcgplayer_id, :object, :oracle_id,
  :prints_search_uri, :rulings_uri, :scryfall_uri, :uri, :cmc, :colors,
  :color_identity, :color_indicator, :edhrec_rank, :foil, :hand_modifier,
  :layout, :legalities, :life_modifier, :loyalty, :mana_cost, :name, :nonfoil,
  :oracle_text, :oversized, :power, :reserved, :toughness, :type_line, :artist,
  :border_color, :collector_number, :digital, :flavor_text, :frame, :frame_effect,
  :full_art, :games, :hires_image, :illustration_id, :image_uris, :printed_name,
  :printed_text, :printed_type_line, :promo, :purchase_uris, :rarity, :related_uris,
  :released_at, :reprint, :scryfall_set_uri, :set, :set_name, :set_search_uri,
  :set_uri, :story_spotlight, :watermark

  has_many :user_cards, dependent: :destroy
  has_many :users, through: :user_cards
end
