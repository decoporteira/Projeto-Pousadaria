class PricesController < ApplicationController
    before_action :set_price, only: [:show, :edit, :update, :destroy] 
    def index
        @prices = Price.all
    end

    def new
        @price = Price.new
        @room_id = params[:format]
    end

    def edit
       @room_id = @price.room_id
    end

    def show

    end

    def create
        @price = Price.new(price_params)
        if @price.save()
           redirect_to room_path(@price.room_id), notice: "Novo preço cadastrado com sucesso."
        else
            flash.now[:notice] = "Novo preço não cadastrado."
            render :new, status: 422
        end
    end

    def update
        old_price = Price.find(@price.id)
        @price.update(price_params)
        @price.room_id = old_price.room_id
        
        if @price.save()
           redirect_to room_path(@price.room_id), notice: 'Preço alterado com sucesso.'
        else  
            flash.now[:notice] = "Preço não alterado."
            render :new, status: 422
        end
    end

    def destroy
        @price.destroy()
        redirect_to room_path(@price.room_id), notice: 'Precificação removida com sucesso.'
    end

    private
    def price_params
        price_params = params.require(:price).permit(:new_rate, :start_date, :final_date, :room_id)
    end
    
    def set_price
        @price = Price.find(params[:id])
    end


end