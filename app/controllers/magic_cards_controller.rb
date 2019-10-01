class MagicCardsController < ApplicationController
  def show
    @card = MagicCard.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @card}
    end
  end

  def index
    # name = params["magic_card_name"]
    # name = name.class == Array ? name.split(" - ")[0] : name
    # if name
    #   @cards = MagicCard.where('lower(name) LIKE ?', "%#{name}%")
    # else
    #   @cards = MagicCard.select(
    #     :id,
    #     :image_uris,
    #     :name,
    #     :set,
    #     :set_name,
    #     :mana_cost,
    #     :type_line,
    #     :oracle_text,
    #     :power,
    #     :toughness
    #   ).where.not(multiverse_ids: []).order(Arel.sql("CAST(multiverse_ids[1] AS INT)")) + MagicCard.select(
    #     :id,
    #     :image_uris,
    #     :name,
    #     :set,
    #     :set_name,
    #     :mana_cost,
    #     :type_line,
    #     :oracle_text,
    #     :power,
    #     :toughness
    #   ).where(multiverse_ids: [])
    # end
    # @pagy, @magic_cards = pagy_array(@cards, items: 10)
    name = params["magic_card_name"].split(" - ")[0] if params["magic_card_name"]
    if name
      @pagy, @magic_cards = pagy(MagicCard.where('lower(name) LIKE ?', "%#{name}%"), items: 10)
    else
      @pagy, @magic_cards = pagy(MagicCard.select(
        :id,
        :image_uris,
        :name,
        :set,
        :set_name,
        :mana_cost,
        :type_line,
        :oracle_text,
        :power,
        :toughness
      ).order(Arel.sql("CAST(multiverse_ids[1] AS INT) NULLS LAST")), items: 10)
      # .merge(MagicCard.select(
      #   :id,
      #   :image_uris,
      #   :name,
      #   :set,
      #   :set_name,
      #   :mana_cost,
      #   :type_line,
      #   :oracle_text,
      #   :power,
      #   :toughness
      # ).where(multiverse_ids: []))
    end
#.where.not(multiverse_ids: [])
    respond_to do |format|
      format.html { render :index }
      #format.json { render json: MagicCard.all, include: '*.*'}
    end
  end
end
