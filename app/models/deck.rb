class Deck < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :user_cards, through: :deck_cards
  has_many :magic_cards, through: :user_cards
  accepts_nested_attributes_for :deck_cards

  FORMATS = [ "Standard", "Modern", "Legacy", "Vintage", "Sealed Deck", "Booster Draft", "Rochester Draft",
              "Two-Headed Giant", "Pauper", "Peasant", "Frontier", "Rainbow Stairwell", "Singleton", "Tribal Wars",
              "Cube Draft", "Back Draft", "Reject Rare Draft", "Type 4", "Free-For-All", "Star", "Assassin", "Emperor",
              "Vanguard", "Planar Magic", "Archenemy", "Commander", "Brawl", "Mental Magic", "Mini-Magic", "Horde Magic",
              "QL Magic", "Fat Stack/Tower of Power", "Pack War", "Penny Dreadful", "Commander Adventures", "Old School" ]

  def self.formats
    FORMATS
  end

  def deck_cards_attributes=(deck_card_attributes)
    deck_card_attributes.values.each do |deck_card_attribute|
      binding.pry
      deck_card = DeckCard.find_or_create_by(deck_card_attribute)
      #self.deck_cards << deck_card
    end
  end

  # I dont think i need these options in a database, I can just check names against ban/restricted lists
  # t.boolean :standard
  # t.boolean :modern
  # t.boolean :legacy
  # t.boolean :vintage
  # t.boolean :sealed_deck
  # t.boolean :booster_draft
  # t.boolean :rochester_draft
  # t.boolean :two_headed_giant
  # t.boolean :pauper
  # t.boolean :peasant
  # t.boolean :frontier
  # t.boolean :rainbow_stairwell
  # t.boolean :singleton
  # t.boolean :tribal_wars
  # t.boolean :cube_draft
  # t.boolean :back_draft
  # t.boolean :reject_rare_draft
  # t.boolean :type_4
  # t.boolean :free_for_all
  # t.boolean :star
  # t.boolean :assassin
  # t.boolean :emperor
  # t.boolean :vanguard
  # t.boolean :planar_magic
  # t.boolean :archenemy
  # t.boolean :commander
  # t.boolean :brawl
  # t.boolean :mental_magic
  # t.boolean :mini_magic
  # t.boolean :horde_magic
  # t.boolean :ql_magic
  # t.boolean :fat_stack_tower_of_power
  # t.boolean :pack_war
  # t.boolean :penny_dreadful
  # t.boolean :commander_adventures
  # t.boolean :old_school
end
