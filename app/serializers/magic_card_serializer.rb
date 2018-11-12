class MagicCardSerializer < ActiveModel::Serializer

  has_many :user_cards, dependent: :destroy
  has_many :users, through: :user_cards
end
