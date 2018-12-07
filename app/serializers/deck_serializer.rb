class DeckSerializer < ActiveModel::Serializer
  attributes :name, :format, :user_id, :id

  belongs_to :user
  has_many :deck_cards
  has_many :user_cards
  has_many :magic_cards

end
