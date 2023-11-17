class ReservationsController < ApplicationController
    before_action :authenticate_guest!, only: [:new, :show]
    before_action :set_room
    before_action :set_inn
    before_action :set_reservation, only: [:show]
    
    def new
        @reservation = Reservation.new
        @reservation.total_price = session[:price]
        @reservation.guest_number = session[:guest]
        @reservation.start_date = session[:start]
        @reservation.final_date = session[:final]
        range = @reservation.start_date..@reservation.final_date
    end

    def show

    end

    def check
        @reservation = Reservation.new
    end

    def create
        @prices = Price.where(room_id: @room.id)
        @reservation = Reservation.new(set_params)
        @reservation.guest_id = current_guest.id
        @reservation.room_id = @room.id

       
        if @reservation.save()
            redirect_to room_reservation_path(@room, @reservation), notice: 'Reserva confirmada com sucesso.'
        else  
            flash.now[:notice] = "Reserva não foi confirmada, tente novamente."
            render :new, status: 422
        end
    end

    def confirm
        @reservation = Reservation.new
        @reservation.total_price
        @reservation.guest_number
        @reservation.start_date
        @reservation.final_date
        
    end
    
    def validates
        if params[:reservation].nil? || params[:reservation][:guest_number].blank? || params[:reservation][:start_date].blank? || params[:reservation][:final_date].blank?
            return redirect_to check_room_reservations_path(@room), notice: 'Campos não podem estar vazios.'   
            
        end

        @reservation = Reservation.new
        session[:has_pre_reservation] = true
        session[:room] = @room.id
        session[:guest] = params[:reservation][:guest_number]
        session[:start] = params[:reservation][:start_date]
        session[:final] = params[:reservation][:final_date]
        guest_number = params[:reservation][:guest_number].to_i
        guest_rule = @room.guest.to_i
        current_range = (params[:reservation][:start_date].to_date)..(params[:reservation][:final_date].to_date)
        @room.reservations.each do |reservation|
            loop_range = reservation.start_date..reservation.final_date
            
            if current_range.overlaps?(loop_range)
                flash.now[:notice] = "Pre-reserva não pode ser feita, data já foi reservada."    
               return render :check, status: 422
            elsif guest_number > guest_rule
                flash.now[:notice] = "Pre-reserva não pode ser feita, mais hóspedes do que o quarto comporta."    
                return  render :check, status: 422
            else
                @reservation.total_price = check_value(current_range)
                @reservation.guest_number = guest_number
                @reservation.start_date = params[:reservation][:start_date].to_date
                @reservation.final_date = params[:reservation][:final_date].to_date
                session[:price] = @reservation.total_price
                flash.now[:notice] = "Pre-reserva feita com sucesso."    
                return  render 'reservations/confirm', status: 422    
            end
        end
        session[:price] = @reservation.total_price = current_range.count *  @room.daily_rate
        flash.now[:notice] = "Pre-reserva feita com sucesso."    
        render 'reservations/confirm', status: 422  
    end
   
    private
    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    def set_room
        @room = Room.find(params[:room_id])
    end

    def set_inn
        @inn = Inn.find_by(id: @room.inn_id)
    end
   
    def check_value(range)
        total_price = 0
        season_days = 0
        range.each do |day|
            @room.prices.each do |price|
                if day.between?(price.start_date, price.final_date) == true
                    total_price = total_price + price.new_rate
                    season_days += 1
                end
            end
        end
        
        total_regular_price = range.count - season_days
        total_price = total_price + (total_regular_price * @room.daily_rate)
        @total_price = total_price
    end

    def set_params
        reservation_params = params.require(:reservation).permit(:guest_number, :start_date, :final_date, :total_price, :room_id, :guest_id)
    end
end
