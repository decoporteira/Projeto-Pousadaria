class PricesController < ApplicationController
    def index
        @prices = Price.all
    end

    def new
        @price = Price.new
        @room_id = params[:format].to_i
    end

    def create
        
        # p @room = Room.find(price_params[:room_id].to_i)
        @price = Price.new(price_params)
        if @price.save()
           redirect_to rooms_path, notice: "Novo preço cadastrado com sucesso."
        else
            flash.now[:notice] = "Novo preço não cadastrado."
            render :new, status: 422
        end
    end

    private
    def price_params
        price_params = params.require(:price).permit(:new_rate, :start_date, :final_date, :room_id)
    end

end