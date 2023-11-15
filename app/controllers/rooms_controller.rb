class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :book, :destroy] 
    before_action :authenticate_owner!, only: [:edit, :update, :destroy, :index]
    before_action :can_edit, only: [:edit, :update]

    def index
        @inn = Inn.find_by(owner_id: current_owner.id )
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
        @inn = Inn.find_by(owner_id:current_owner.id )
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
        @inn = Inn.find_by(owner_id: current_owner.id )
        redirect_to root_path unless @room.inn_id == @inn.id
    end
end