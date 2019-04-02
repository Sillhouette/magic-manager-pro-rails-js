class AddCardTypeToMagicCards < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_cards, :card_type, :string
  end
end
