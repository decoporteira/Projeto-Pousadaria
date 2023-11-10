class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy, :check_price] 
    before_action :authenticate_user!
    before_action :can_edit, only: [:edit, :update]
    before_action :check_price

    def index
        @inn = Inn.find_by(user_id: current_user.id )
        @rooms = Room.where(inn_id: @inn.id)
    end

    def new
        @room = Room.new
    end

    def edit
       
    end
    def show
        @prices = Price.where(room_id: @room.id)
    end

    def create 
        @inn = Inn.find_by(user_id:current_user.id )
        @room = Room.new(room_params)
        @room.inn_id = @inn.id
        if @room.save()
           redirect_to rooms_path, notice: "Quarto cadastrado com sucesso."
        else
            flash.now[:notice] = "Quarto não cadastrado."
            render :new, status: 422
        end
    end

    def update
        @room.update(room_params)
        if @room.save()
            redirect_to room_path(@room), notice: 'Quarto alterado com sucesso.'
        else  
            flash.now[:notice] = "Quarto não alterado."
            render :new, status: 422
        end
    end

    def destroy  
        @room.destroy()
        redirect_to rooms_path, notice: 'Quarto removido com sucesso.'
    end
    

    private
    def room_params
        room_params = params.require(:room).permit(:name, :description, :guest, :size, :daily_rate, :balcony, :air_conditioner, :tv, :wardrobe, :safe, :accessible, :available)
    end

    def set_room
        @room = Room.find(params[:id])
    end

    def can_edit
        @inn = Inn.find_by(user_id: current_user.id )
        redirect_to root_path unless @room.inn_id == @inn.id
    end

    def check_price
        @rooms = Room.all
        @rooms.each do |room|
            if room && room.prices.length == 0
                room.daily_rate = room.daily_rate
            else
                prices_of_room = room.prices
                prices_of_room.each do |price|
                    ranges_of_dates = Price.where(start_date: price.start_date..price.final_date, room_id: room)
                    ranges_of_dates.each do |date|
                        current_range = Range.new(date.start_date, date.final_date)
                        if current_range && current_range.include?(Date.today)
                           
                            room.daily_rate = date.new_rate 
                        else
                           
                            room.daily_rate = room.daily_rate
                        end

                    end
                end

            end
        end
    end

end