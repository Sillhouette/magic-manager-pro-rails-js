class AddWatermarkToCardFaces < ActiveRecord::Migration[5.2]
  def change
    add_column :card_faces, :watermark, :string
  end
end
