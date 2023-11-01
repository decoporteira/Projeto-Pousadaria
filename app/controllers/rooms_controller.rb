class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update] 
    before_action :authenticate_user!
    before_action :can_edit, only: [:edit, :update, :destroy]

    def index
        @inn = Inn.find_by(user_id: current_user.id )
        @rooms = Room.where(inn_id: @inn.id)
    end

    def new
        @room = Room.new
    end

    def edit
       
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
            flash.now[:notice] = "Qaurto não alterado."
            render :new, status: 422
        end
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
end