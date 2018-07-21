class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.string :name
      t.string :format
      t.integer :user_id

      # => These should all be deck_list methods probably not even stored to be honest
      # t.integer :card_count
      # t.integer :creature_count
      # t.integer :instant_sorcery_count
      # t.integer :land_count
      # t.integer :artifact_enchantment_count
      # t.integer :planeswalker_count
      # t.integer :sideboard_count
      t.timestamps
    end
  end
end
