class UserCard < ApplicationRecord
  belongs_to :user
  belongs_to :magic_card
  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards

  validates :magic_card_name, presence: true
  validates :quantity, presence: true

  def legal?(format_name)
    self.magic_card.legalities.include?("#{format_name}: Legal") || self.magic_card.legalities.include?("#{format_name}: Restricted") && !self.magic_card.legalities.include?("#{format_name}: Banned")
  end

  def self.find_by_full_name(name)
    full_name = name.split(" - ")
    magic_card = MagicCard.find_by(name: full_name[0], setname: full_name[1])
    if magic_card
      UserCard.find_by(magic_card_id: magic_card.id)
    end
  end

  def magic_card_name
    self.magic_card.name + " - " + self.magic_card.setname if magic_card
  end

  def magic_card_name=(name)
    self.magic_card = MagicCard.find_by(name: name.split(" - ")[0], setname: name.split(" - ")[1])
  end
end
