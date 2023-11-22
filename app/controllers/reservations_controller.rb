class ReservationsController < ApplicationController
    before_action :authenticate_guest!, only: [:new]
    before_action :authenticate_guest_or_owner!, only: [:show]
    before_action :set_room, only: [:new, :show, :check, :confirm, :validates, :create, :cancel_reservation, :check_in, :stay, :cancel_reservation_by_owner, :check_out]
    before_action :set_inn, only: [:new, :show, :create, :cancel_reservation, :check_in, :stay, :cancel_reservation_by_owner, :check_out]
    before_action :set_reservation, only: [:show, :cancel_reservation, :check_in, :stay, :cancel_reservation_by_owner, :check_out]
    

    def index
        @reservations = Reservation.where(guest_id: current_guest.id)
    end
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
    
    def list
        @reservations = Reservation.where(guest_id: current_guest.id, status: [:active, :ended])
    end

    def check
        @reservation = Reservation.new
    end

    def create
        @prices = Price.where(room_id: @room.id)
        @reservation = Reservation.new(set_params)
        @reservation.guest_id = current_guest.id
        @reservation.room_id = @room.id
        @reservation.status = 1

        
        if @reservation.save()
            redirect_to list_path, notice: 'Reserva confirmada com sucesso.'
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
        @reservation.room_id = session[:room] = @room.id
        @reservation.start_date = session[:start] = params[:reservation][:start_date]
        @reservation.final_date = session[:final] = params[:reservation][:final_date]
        @reservation.guest_number = session[:guest] = params[:reservation][:guest_number].to_i
        if @reservation.valid?
            current_range = @reservation.start_date..@reservation.final_date 
            @reservation.total_price = session[:price] = check_value(current_range)
            flash.now[:notice] = "Pre-reserva feita com sucesso."    
            return  render 'reservations/confirm', status: 422

        else
            flash.now[:notice] = "Pre-reserva não pode ser feita, data já foi reservada ou número hóspedes é maior do que a o quarto suporta."    
            return render :check, status: 422
        end 
    end
   
    def cancel_reservation
        if @reservation.start_date < 7.day.from_now 
            flash.now[:notice] = "A reserva não pode ser cancelada com menos de 7 dias para o check in."    
            return render :show, status: 422 
        else
           @reservation.update(status: :canceled)
            redirect_to room_reservation_path(@room, @reservation), notice: 'Reserva cancelada com sucesso.'
        end
       
    end

    def cancel_reservation_by_owner
        if @reservation.start_date.to_date <= Date.today - 2 
            @reservation.update_column(:status, :canceled)
            redirect_to room_reservation_path(@room, @reservation), notice: 'Reserva cancelada com sucesso.'
        else
            flash.now[:notice] = "A reserva não pode ser cancelada antes do segundo dia do Check in"    
            return render :show, status: 422 
        end
    end

    def check_in
        if @reservation.start_date >= Date.today
            @reservation.update!(status: :'active stay', check_in_date: Date.today, check_in_time: Time.zone.now)
            return redirect_to stay_room_reservation_path(@room, @reservation), notice: "Check in do hóspede feito com sucesso"
        else
            flash.now[:notice] = "O check in não pode ser feito antes do dia de entrada da reserva."    
            return render :show, status: 422 
        end
    end

    def check_out
            if Time.zone.now.strftime('%H:%M') > @inn.check_out.strftime('%H:%M')
                new_price = check_value(@reservation.check_in_date..1.day.from_now)  
            else
                new_price = check_value(@reservation.check_in_date..Date.today)
            end 

            @reservation.update!(status: :'ended', check_out_date: Date.today, check_out_time: Time.zone.now, total_price: new_price, payment: params["payment"])
            return redirect_to stay_room_reservation_path(@room, @reservation), notice: "Check out do hóspede feito com sucesso"
    end

    def stay

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

    def authenticate_guest_or_owner!
        unless owner_signed_in? || guest_signed_in?
            redirect_to root_path, alert: 'Você precisa estar logado para ter acesso a essa informação.'
        end
    end
end
