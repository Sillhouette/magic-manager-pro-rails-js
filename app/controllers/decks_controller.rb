class DecksController < ApplicationController
  def new
    @deck = Deck.new
    @deck_card = DeckCard.new
  end

  def show

  end
end
