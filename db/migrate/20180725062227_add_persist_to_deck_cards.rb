class AddPersistToDeckCards < ActiveRecord::Migration[5.2]
  def change
    add_column :deck_cards, :persist, :boolean
  end
end
