class DeckCard < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  belongs_to :deck
  belongs_to :user_card

  # => These should all be deck_card methods probably not even stored to be honest
  # card_count
  # creature_count
  # instant_sorcery_count
  # land_count
  # artifact_enchantment_count
  # planeswalker_count
  # sideboard_count
end
