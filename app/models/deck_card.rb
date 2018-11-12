class DeckCard < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  belongs_to :deck
  belongs_to :user_card

  #validate :max_number_of_cards

  def max_number_of_cards
    if !self.user_card.magic_card.types.include?("Basic Land")
      if self.user_card.magic_card.legalities.include?("#{self.deck.format}: Restricted")
        if main_board_quantity + side_board_quantity > 1
          errors.add(:main_board_quantity, "You can only have one copy of a restricted card in your deck. (Including sideboard)")
          errors.add(:side_board_quantity, "You can only have one copy of a restricted card in your deck. (Including sideboard)")
        end
      elsif main_board_quantity + side_board_quantity > 4
        errors.add(:main_board_quantity, "You can only have four copies of a card in your deck. (Including sideboard)")
        errors.add(:side_board_quantity, "You can only have four copies of a card in your deck. (Including sideboard)")
      end
    end
  end

  # => These should all be deck_card methods probably not even stored to be honest
  # card_count
  # creature_count
  # instant_sorcery_count
  # land_count
  # artifact_enchantment_count
  # planeswalker_count
  # sideboard_count
end
