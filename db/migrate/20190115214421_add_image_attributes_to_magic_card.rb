class AddImageAttributesToMagicCard < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_cards, :image_url, :string
    add_column :magic_cards, :small_image, :string
    add_column :magic_cards, :large_image, :string
    add_column :magic_cards, :art_crop, :string
    add_column :magic_cards, :border_crop, :string
    add_column :magic_cards, :png, :string
  end
end
