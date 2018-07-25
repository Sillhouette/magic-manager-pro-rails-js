class RemovePersistFromDeckCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :deck_cards, :persist, :boolean
  end
end
