class MagicCardSerializer < ActiveModel::Serializer
  attributes  :name, :layout, :cmc, :colors, :color_identity, :card_type, :supertypes,
              :types, :subtypes, :rarity, :set, :set_name, :text, :flavor, :artist,
              :number, :power, :toughness, :loyalty, :card_id, :multiverse_ids, :other_names,
              :mana_cost, :variations, :image_url, :small_image, :large_image, :png, :art_crop,
              :border_crop, :watermark, :border, :timeshifted, :hand,
              :life, :reserved, :release_date, :starter, :rulings, :original_text, :original_type,
              :legalities, :source

  has_many :user_cards, dependent: :destroy
  has_many :users, through: :user_cards
end
