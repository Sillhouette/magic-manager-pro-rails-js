class DecksController < ApplicationController
  def new
    @deck = Deck.new
    current_user.user_cards.each do |card|
      @deck.deck_cards.build(user_card: card)
    end
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def index

  end

  def create
    @deck = current_user.decks.create(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      flash[:error] = "You tried to add an invalid card, please try again."
      render :new
    end
  end

  def update
    raise params.inspect
  end

  def destroy
    @deck = Deck.find_by(id: params[:id])
    @deck.delete
    redirect_to decks_path
  end

  def deck_params
    params.require(:deck).permit(:name, :format, deck_cards_attributes: [:user_card_id, :main_board_quantity, :side_board_quantity, :main_board_option, :side_board_option])
  end
end
