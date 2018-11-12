class UserCardSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :magic_card
  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards

end
