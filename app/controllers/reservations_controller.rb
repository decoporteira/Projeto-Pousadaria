class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: [:new]
    before_action :set_room
    
    def new
        @reservation = Reservation.new
    end
    def check
        @reservation = Reservation.new
    end

    def create
        
    end

    def confirm
        @reservation = Reservation.new
        @reservation.total_price
        @reservation.guest_number
        @reservation.start_date
        @reservation.final_date
    end
    def validates
        @reservation = Reservation.new
        guest_number = params[:reservation][:guest_number].to_i
        guest_rule = @room.guest.to_i
        current_range = (params[:reservation][:start_date].to_date)..(params[:reservation][:final_date].to_date)
        @room.reservations.each do |reservation|
            loop_range = reservation.start_date..reservation.final_date
            
            if current_range.overlaps?(loop_range)
                flash.now[:notice] = "Pre-reserva não pode ser feita, data já foi reservada."    
                render :new, status: 422
            elsif guest_number > guest_rule
                flash.now[:notice] = "Pre-reserva não pode ser feita, mais hóspedes do que o quarto comporta."    
                render :new, status: 422
            else
                @reservation.total_price = check_value(current_range)
                @reservation.guest_number = guest_number
                @reservation.start_date = params[:reservation][:start_date].to_date
                @reservation.final_date = params[:reservation][:final_date].to_date

                flash.now[:notice] = "Reserva feita com sucesso."    
                render 'reservations/confirm', status: 422    
            end
        end
    end
   

    private

    def set_room
        @room = Room.find(params[:room_id])
    end
   
    def check_value(range)
        range
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

end
