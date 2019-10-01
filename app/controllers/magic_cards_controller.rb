class MagicCardsController < ApplicationController
  def show
    @card = MagicCard.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @card}
    end
  end

  def index

    respond_to do |format|
      format.html {
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
        end
        render :index
      }

      format.json {
          # paginate as usual with any pagy_* backend constructor
          @pagy, @records = pagy(MagicCard.all, items: 20)
          # explicitly merge the headers to the response
          pagy_headers_merge(@pagy)
          render json: @records, include: '*.*'
       }
    end
  end
end
