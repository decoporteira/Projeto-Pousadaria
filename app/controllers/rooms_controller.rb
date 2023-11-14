class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :book, :destroy, :check_availability, :pre_reservation] 
    before_action :authenticate_user!, only: [:edit, :update, :destroy, :index]
    before_action :can_edit, only: [:edit, :update]

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
    def pre_reservation

    end
    def check_availability
        guest_number = params[:room][:guest_number].to_i
        guest_rule = @room.guest.to_i
        current_range = (params[:room][:start_date].to_date)..(params[:room][:final_date].to_date)
        @room.reservations.each do |reservation|
            loop_range = reservation.start_date..reservation.final_date
            
            if current_range.overlaps?(loop_range)
                flash.now[:notice] = "Pre-reserva não pode ser feita, data já foi reservada."    
                render :pre_reservation, status: 422
            elsif guest_number > guest_rule
                flash.now[:notice] = "Pre-reserva não pode ser feita, mais hóspedes do que o quarto comporta."    
                render :pre_reservation, status: 422
                else
                    redirect_to pre_reservation_room_path(@room), notice: 'Reserva feita com sucesso.'
            end
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