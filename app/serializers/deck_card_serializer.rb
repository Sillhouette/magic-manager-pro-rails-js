class DeckCardSerializer < ActiveModel::Serializer
  attributes :deck_id, :user_card_id, :side_board_quantity, :main_board_quantity, :side_board_option, :main_board_option

  belongs_to :deck
  belongs_to :user_card

end
