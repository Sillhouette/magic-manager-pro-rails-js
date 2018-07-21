class CreateMagicCards < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_cards do |t|
      t.string :name
      t.string :layout
      t.string :cmc
      t.string :colors
      t.string :color_identity
      t.string :card_type
      t.string :supertypes
      t.string :types
      t.string :subtypes
      t.string :rarity
      t.string :set_code
      t.string :setname
      t.string :text
      t.string :flavor
      t.string :artist
      t.string :number
      t.string :power
      t.string :toughness
      t.string :loyalty
      t.string :card_id
      t.string :multiverse_id
      t.string :other_names
      t.string :mana_cost
      t.string :variations
      t.string :image_url
      t.string :watermark
      t.string :border
      t.boolean :timeshifted
      t.string :hand
      t.string :life
      t.boolean :reserved
      t.string :release_date
      t.boolean :starter
      t.string :rulings
      t.string :original_text
      t.string :original_type
      t.string :legalities
      t.string :source

      # => These should be in the deck_list join table
      # t.boolean :side_board_quantity #Should be in the join table
      # t.boolean :main_board_quantity #should be in the join table
      # t.boolean :side_board_option #Should be in the join table
      # t.boolean :main_board_option #should be in the join table

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
