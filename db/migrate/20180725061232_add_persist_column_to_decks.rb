class AddPersistColumnToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :persist, :boolean
  end
end
