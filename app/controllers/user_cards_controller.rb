class UserCardsController < ApplicationController
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
        redirect_to user_path(@user)
      else
        flash[:error] = "You tried to add an invalid card, please try again."
        render :new
      end
    end
  end

  private

  def user_card_params
    params.require(:user_card).permit(:magic_card_name, :quantity, :quality, :value)
  end

  def check_for_card
    current_user.user_cards.find_by_full_name(params[:user_card][:magic_card_name])
  end
end
