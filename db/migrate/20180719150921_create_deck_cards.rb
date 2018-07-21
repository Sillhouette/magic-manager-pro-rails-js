class CreateDeckCards < ActiveRecord::Migration[5.2]
  def change
    create_table :deck_cards do |t|
      t.integer :deck_id
      t.integer :user_card_id
      t.integer :side_board_quantity #Should be in the join table
      t.integer :main_board_quantity #should be in the join table
      t.boolean :side_board_option #Should be in the join table
      t.boolean :main_board_option #should be in the join table
      t.timestamps
    end
  end
end
