class ChangeMagicCardToPostgresSupportedTypes < ActiveRecord::Migration[5.2]
  def change
    drop_table :magic_cards
    create_table :magic_cards, id: :uuid  do |t|
      t.string :supertypes, array:true, default: []                                 #array
      t.string :types, array:true, default: []                                       #array
      t.string :subtypes, array:true, default: []                                    #array
      t.string :other_names, array:true, default: []                                 #array
      t.string :variations, array:true, default: []                                  #array
      t.string :original_text                               #string
      t.string :original_type                               #string
      t.json :rulings, null: false, array:true, default: []                                     #array of hashes
      t.string :arena_id                                    #string
      t.uuid :scryfall_id                                 #uuid
      t.string :lang                                        #string
      t.string :mtgo_id                                     #string
      t.string :mtgo_foil_id                                #string
      t.string :multiverse_ids, array:true, default: []                              #array
      t.string :tcgplayer_id                                #string
      t.string :object                                      #string
      t.uuid :oracle_id                                   #uuid
      t.string :prints_search_uri                           #string
      t.string :rulings_uri                                 #string
      t.string :scryfall_uri                                #string
      t.string :uri                                         #string
      t.decimal :cmc                                         #decimal
      t.string :colors, array:true, default: []                                      #array
      t.string :color_identity, array:true, default: []                              #array
      t.string :color_indicator, array:true, default: []                             #array
      t.integer :edhrec_rank                                 #integer
      t.boolean :foil                                        #boolean
      t.string :hand_modifier                               #string
      t.string :layout                                      #string
      t.json :legalities, default: {}, null: false          #hash
      t.string :life_modifier                               #string
      t.string :loyalty                                     #string
      t.string :mana_cost                                   #string
      t.string :name                                        #string
      t.boolean :nonfoil                                     #boolean
      t.string :oracle_text                                 #string
      t.boolean :oversized                                   #boolean
      t.string :power                                       #string
      t.boolean :reserved                                    #boolean
      t.string :toughness                                   #string
      t.string :type_line                                   #string
      t.string :artist                                      #string
      t.string :border_color                                #string
      t.string :collector_number                            #string
      t.boolean :digital                                     #boolean
      t.string :flavor_text                                 #string
      t.string :frame                                       #string
      t.string :frame_effect                                #string
      t.boolean :full_art                                    #boolean
      t.string :games, array:true, default: []                                       #array
      t.boolean :hires_image                                 #boolean
      t.uuid :illustration_id                             #uuid
      t.json :image_uris, default: {}, null: false          #hash
      t.string :printed_name                               #string
      t.string :printed_text                               #string
      t.string :printed_type_line                          #string
      t.boolean :promo                                      #boolean
      t.json :purchase_uris, default: {}, null: false       #hash
      t.string :rarity                                      #string
      t.json :related_uris                                #hash
      t.string :released_at                                 #string
      t.boolean :reprint                                     #boolean
      t.string :scryfall_set_uri                            #string
      t.string :set                                         #string
      t.string :set_name                                    #string
      t.string :set_search_uri                              #string
      t.string :set_uri                                     #string
      t.boolean :story_spotlight                             #boolean
      t.string :watermark                                   #string
      t.timestamps
    end
  end
end
