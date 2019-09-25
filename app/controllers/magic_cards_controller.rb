class MagicCardsController < ApplicationController
  def show
    @card = MagicCard.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @card}
    end
  end

  def index
    @cards = [MagicCard.where.not(multiverse_ids: []).order(Arel.sql("CAST(multiverse_ids[1] AS INT)")), MagicCard.where(multiverse_ids: [])]
    @pagy, @magic_cards = pagy_array(@cards, items: 10)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: MagicCard.all, include: '*.*'}
    end
  end
end
