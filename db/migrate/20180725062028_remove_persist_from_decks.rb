class RemovePersistFromDecks < ActiveRecord::Migration[5.2]
  def change
    remove_column :decks, :persist, :boolean
  end
end
