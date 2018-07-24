class MagicCardsController < ApplicationController
  def show
    @card = MagicCard.find_by(id: params[:id])
  end
end
