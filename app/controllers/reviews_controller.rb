class ReviewsController < ApplicationController
    before_action :set_reservation, only: [:new, :create, :show]
    before_action :set_room, only: [:new, :create, :show]
    before_action :set_inn, only: [:new, :show]

    def new
        @review = Review.new
    end

    def show
        @review = Review.find(params[:id])
    end
    def create
        @review = Review.new(set_params)
        @review.reservation_id = @reservation.id
        if @review.save!()
            redirect_to room_reservation_review_path(@room, @reservation, @review), notice: 'Avaliação enviada com sucesso.'
        else  
            flash.now[:notice] = "Avaliação não enviada, tente novamente."
            render :new, status: 422
        end
        
    end

    private
    def set_room
        @room = Room.find(params[:room_id])
    end
    def set_reservation
        @reservation = Reservation.find(params[:reservation_id])
    end
    def set_inn
        @inn = Inn.find(@room.inn_id)
    end
    def set_params
       review_params = params.require(:review).permit(:rating, :comment, :reply, :room_id, :reservation_id)
    end
end