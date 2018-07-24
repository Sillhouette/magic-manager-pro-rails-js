class UserCardsController < ApplicationController

  def index
  end

  def new
    @card = UserCard.new
  end

  def create
    if check_for_card
      flash[:error] = "Please edit your card rather than adding it again."
      redirect_to edit_user_card_path(check_for_card)
    else
      @card = current_user.user_cards.build(user_card_params) #use .create instead of build?
      if @card.save
        redirect_to user_cards_path
      else
        flash[:error] = "You tried to add an invalid card, please try again."
        render :new
      end
    end
  end

  def edit
    @card = UserCard.find_by(id: params[:id])
  end

  def update
    @card = UserCard.find_by(id: params[:id])
    if @card.update(user_card_params)
      redirect_to user_cards_path
    else
      flash[:error] = "The update failed, please try again."
      render :edit
    end
  end

  def destroy
    @card = UserCard.find_by(id: params[:id])
    @card.delete
    redirect_to user_cards_path
  end

  private

  def user_card_params
    params.require(:user_card).permit(:magic_card_name, :quantity, :quality, :value)
  end

  def check_for_card
    current_user.user_cards.find_by_full_name(params[:user_card][:magic_card_name])
  end
end
