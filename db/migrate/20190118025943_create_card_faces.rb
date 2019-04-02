class CreateCardFaces < ActiveRecord::Migration[5.2]
  def change
    create_table :card_faces, id: :uuid do |t|
      t.string :artist
      t.string :color_indicator, array:true, default: []
      t.string :colors, array:true, default: []
      t.string :flavor_text
      t.uuid :illustration_id
      t.json :image_uris, default: {}, null: false
      t.string :loyalty
      t.string :mana_cost
      t.string :name
      t.string :object
      t.string :oracle_text
      t.string :power
      t.string :printed_name
      t.string :printed_text
      t.string :printed_type_line
      t.string :toughness
      t.string :type_line
      t.uuid :magic_card_id
    end
  end
end
