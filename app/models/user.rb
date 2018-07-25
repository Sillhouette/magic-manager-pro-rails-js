class User < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  has_many :decks, dependent: :destroy
  has_many :user_cards, dependent: :destroy
  has_many :magic_cards, through: :user_cards

  has_secure_password
end
