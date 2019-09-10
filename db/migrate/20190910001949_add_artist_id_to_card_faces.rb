class AddArtistIdToCardFaces < ActiveRecord::Migration[5.2]
  def change
    add_column :card_faces, :artist_id, :string
  end
end
