class UserSerializer < ActiveModel::Serializer

  has_many :decks, dependent: :destroy
  has_many :user_cards, dependent: :destroy
  has_many :magic_cards, through: :user_cards

end
