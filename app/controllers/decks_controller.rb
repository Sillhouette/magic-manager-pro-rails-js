class DecksController < ApplicationController
  def new
    @user = current_user
    if params[:format] != ""
      @deck = Deck.new(format: params[:format])
      @user.user_cards.each do |card|
        #if card.legal?(params[:format])
          @deck.deck_cards.build(user_card: card)
        #end
      end
    else
      flash[:error] = "Please select a format before creating a new deck."
      render :index
    end
  end

  def show
    @user = current_user
    @deck = Deck.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @deck}
    end
  end

  def index

  end

  def create
    @deck = current_user.decks.create(deck_params)
    if @deck.valid?
      @deck.save
      redirect_to user_decks_path
    else
      current_user.user_cards.each do |card|
        @deck.deck_cards.build(user_card: card)
      end
      render :new
    end
  end

  def edit
    @deck = Deck.find(params[:id])
    diff = current_user.user_cards - @deck.user_cards
    diff.each do |card|
      @deck.deck_cards.build(user_card: card)
    end
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update(deck_params)
      redirect_to user_decks_path
    else
      #flash[:error] = "The update failed, please try again."
      render :edit
    end
  end

  def destroy
    @deck = Deck.find(params[:id])

    #binding.pry
    @deck.destroy
    redirect_to user_decks_path
  end

  def deck_params
    params.require(:deck).permit(:name, :format, deck_cards_attributes: [:persist, :user_card_id, :main_board_quantity, :side_board_quantity, :main_board_option, :side_board_option])
  end
end
