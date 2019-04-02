class CreateRelatedCards < ActiveRecord::Migration[5.2]
  def change
    create_table :related_cards, id: :uuid do |t|
      t.uuid :scryfall_id
      t.string :object
      t.string :component
      t.string :name
      t.string :type_line
      t.string :uri
      t.uuid :magic_card_id
    end
  end
end
