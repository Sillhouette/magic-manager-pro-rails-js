class CreateMagicCards < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_cards do |t|

      t.timestamps
    end
  end
end
