class ChangeValueToBeStringgInUserCards < ActiveRecord::Migration[5.2]
  def change
    change_column :user_cards, :value, :string
  end
end
