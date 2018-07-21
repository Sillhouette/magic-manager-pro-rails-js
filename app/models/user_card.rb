class UserCard < ApplicationRecord
  belongs_to :user
  belongs_to :magic_card
  has_many :deck_cards
  has_many :decks, through: :deck_cards
end
