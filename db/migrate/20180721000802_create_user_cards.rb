class CreateUserCards < ActiveRecord::Migration[5.2]
  def change
    create_table :user_cards do |t|
      t.integer :user_id
      t.integer :magic_card_id
      t.string :quality
      t.float :value
      t.integer :quantity
      t.timestamps
    end
  end
end
