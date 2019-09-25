class AddIndexToMultiverseIdColumnOnMagicCard < ActiveRecord::Migration[5.2]
  def change
    add_index :magic_cards, :multiverse_ids
    add_index :magic_cards, :scryfall_id
    add_index :magic_cards, :name
  end
end
