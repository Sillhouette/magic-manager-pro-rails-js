class UserSerializer < ActiveModel::Serializer

  attributes  :username, :name, :uid, :email, :image, :dci_number

  has_many :decks, dependent: :destroy
  has_many :user_cards, dependent: :destroy
  has_many :magic_cards, through: :user_cards

end
