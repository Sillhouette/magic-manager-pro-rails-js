class ChangeUserCardMagicCardIdToUuid < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_cards, :magic_card_id
    add_column :user_cards, :magic_card_id, :uuid
  end
end
