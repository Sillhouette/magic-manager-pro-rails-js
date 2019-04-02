class RewriteMagicCards < ActiveRecord::Migration[5.2]
  def change
    drop_table :magic_cards
    create_table :magic_cards do |t|
      t.string :supertypes
      t.string :types
      t.string :subtypes
      t.string :other_names
      t.string :variations
      t.string :original_text
      t.string :original_type
      t.string :rulings
      t.string :arena_id
      t.string :scryfall_id
      t.string :lang
      t.string :mtgo_id
      t.string :mtgo_foil_id
      t.string :multiverse_ids
      t.string :tcgplayer_id
      t.string :object
      t.string :oracle_id
      t.string :prints_search_uri
      t.string :rulings_uri
      t.string :scryfall_uri
      t.string :uri
      t.string :all_parts
      t.string :card_faces
      t.string :cmc
      t.string :colors
      t.string :color_identity
      t.string :color_indicator
      t.string :edhrec_rank
      t.string :foil
      t.string :hand_modifier
      t.string :layout
      t.string :legalities
      t.string :life_modifier
      t.string :loyalty
      t.string :mana_cost
      t.string :name
      t.string :nonfoil
      t.string :oracle_text
      t.string :oversized
      t.string :power
      t.string :reserved
      t.string :toughness
      t.string :type_line
      t.string :artist
      t.string :border_color
      t.string :collector_number
      t.string :digital
      t.string :eur
      t.string :flavor_text
      t.string :frame
      t.string :frame_effect
      t.string :full_art
      t.string :games
      t.string :hires_image
      t.string :illustration_id
      t.string :image_uris
      t.string :printed_name
      t.string :printed_text
      t.string :printed_type_line
      t.string :promo
      t.string :purchase_uris
      t.string :rarity
      t.string :related_uris
      t.string :released_at
      t.string :reprint
      t.string :scryfall_set_uri
      t.string :set
      t.string :set_name
      t.string :set_search_uri
      t.string :set_uri
      t.string :story_spotlight
      t.string :tix
      t.string :usd
      t.string :watermark

      # I dont think i need these options in a database, I can just check names against ban/restricted lists
      # t.boolean :standard
      # t.boolean :modern
      # t.boolean :legacy
      # t.boolean :vintage
      # t.boolean :sealed_deck
      # t.boolean :booster_draft
      # t.boolean :rochester_draft
      # t.boolean :two_headed_giant
      # t.boolean :pauper
      # t.boolean :peasant
      # t.boolean :frontier
      # t.boolean :rainbow_stairwell
      # t.boolean :singleton
      # t.boolean :tribal_wars
      # t.boolean :cube_draft
      # t.boolean :back_draft
      # t.boolean :reject_rare_draft
      # t.boolean :type_4
      # t.boolean :free_for_all
      # t.boolean :star
      # t.boolean :assassin
      # t.boolean :emperor
      # t.boolean :vanguard
      # t.boolean :planar_magic
      # t.boolean :archenemy
      # t.boolean :commander
      # t.boolean :brawl
      # t.boolean :mental_magic
      # t.boolean :mini_magic
      # t.boolean :horde_magic
      # t.boolean :ql_magic
      # t.boolean :fat_stack_tower_of_power
      # t.boolean :pack_war
      # t.boolean :penny_dreadful
      # t.boolean :commander_adventures
      # t.boolean :old_school
      t.timestamps
    end
  end
end
