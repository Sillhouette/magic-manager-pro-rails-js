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

  ##
  # => Cycles through nested attributes, pulls the attributes for a single deck_card, checks if the card is in deck already and if so updates
  # => if not it creates the card. This also handles deleting any deck_cards that have an invalid user_card_id due to the way we had to handle
  # => the checkboxes on the forms.
  ##
  def deck_cards_attributes=(deck_card_attributes)
   deck_card_attributes.values.each do |deck_card_attribute|
     if deck_card_attribute[:user_card_id].to_i > 0 #&& !self.deck_cards.pluck(:user_card_id).include?(deck_card_attribute[:user_card_id].to_i)
       if !self.deck_cards.pluck(:user_card_id).include?(deck_card_attribute[:user_card_id].to_i)
         self.deck_cards.build(deck_card_attribute)
       else
         card = self.deck_cards.find_by(user_card_id: deck_card_attribute[:user_card_id])
         card.update(deck_card_attribute)
       end
     elsif deck_card_attribute[:user_card_id].to_i < 0 #&& self.deck_cards.pluck(:user_card_id).include?(-deck_card_attribute[:user_card_id].to_i)
       deck_card = self.deck_cards.where(user_card_id: -deck_card_attribute[:user_card_id].to_i).first
       deck_card.destroy if deck_card
     end
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
