class DeckSerializer < ActiveModel::Serializer
  attributes :name, :format, :user_id

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :user_cards, through: :deck_cards
  has_many :magic_cards, through: :user_cards

end
