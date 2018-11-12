class DeckCardSerializer < ActiveModel::Serializer

  belongs_to :deck
  belongs_to :user_card

end
