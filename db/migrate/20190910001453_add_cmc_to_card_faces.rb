class AddCmcToCardFaces < ActiveRecord::Migration[5.2]
  def change
    add_column :card_faces, :cmc, :string
  end
end
