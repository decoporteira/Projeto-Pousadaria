class Api::V1::InnsController < Api::V1::ApiController
    
    def index
        query = params['query']
        inns = Inn.where("status = 0 AND (trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ?) ", "%#{params['query']}%", "%#{params['query']}%", "%#{params['query']}%").order(:trade_name)
        render status: 200, json: inns.as_json(except: [:created_at, :updated_at])
    end

    def rooms
      
        inn = Inn.find(params[:id])
        inn.rooms
        render status: 200, json: inn.rooms.as_json(except: [:created_at, :updated_at]) 

    end

    def inn_details
        
        inn = Inn.find(params[:id])
        @reviews = Review.joins(reservation: { room: :inn }).where(inns: { id: inn.id })
        @reviews_rating = 'Sem avaliações.'

        if @reviews.any?
            @reviews_rating = 0
            @reviews.each do |review|
                review.rating
                @reviews_rating += review.rating
            end
            @reviews_rating = @reviews_rating / @reviews.length
        end
        
        render status: 200, json: inn.as_json(except: [:created_at, :updated_at]).merge(nota: @reviews_rating)

    end


    def room
        room = Room.find(params[:id])
        reservation = Reservation.new
        reservation.start_date = params[:start]
        reservation.final_date = params[:end]
        reservation.guest_number =params[:guests]
        reservation.room_id = room.id
        if reservation.valid?
            reservation.total_price = reservation.check_value(room)
            return render status: 200, json: reservation.as_json(only: [:total_price])
        else
            render status: 422, json: { error: "Reverva não pode ser feita nessa dia ou número de hóspedes é maior que o quarto comporta." }
        end
    end

    def cities
        all_active_inns = Inn.ativa.order(:city)
        cities = all_active_inns.uniq {|item| item.city}
        return render status: 200, json: cities.as_json(only: [:city])
    end

    def inns_by_city
        all_active_inns = Inn.ativa.where("LOWER(city) LIKE ?", "%#{params[:city].downcase}%")
        return render status: 200, json: all_active_inns.as_json(except: [:created_at, :updated_at])
    end
end