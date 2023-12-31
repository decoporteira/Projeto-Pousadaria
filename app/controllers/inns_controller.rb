class InnsController < ApplicationController
    before_action :authenticate_owner!, only: [:edit]
    before_action :set_inn, only: [:show, :edit, :update, :create_payment_methods] 
    before_action :cant_edit, only: [:edit, :update, :destroy]

 
    def new
        @inn = Inn.new
    end

    def index
        @inn = Inn.find_by(owner_id: current_owner.id) 
    end

    def show
        @reviews = Review.joins(reservation: { room: :inn }).where(inns: { id: @inn.id })
        @reviews_rating = 'Sem avaliações.'

        if @reviews.any?
            @reviews_rating = 0
            @reviews.each do |review|
                review.rating
                @reviews_rating += review.rating
            end
            @reviews_rating = @reviews_rating / @reviews.length
        end
    end

    def edit
    end

    def create  
        @inn = Inn.new(inn_params)
        @inn.owner_id = current_owner.id

        if @inn.save()
            redirect_to root_path, notice: "Pousada cadastrada com sucesso."
        else
            flash.now[:notice] = "Pousada não cadastrada."
            render :new, status: 422
        end
    end
    def update
      
        if @inn.update(inn_params)
           redirect_to inn_path(@inn), notice: 'Pousada alterada com sucesso.'
        else  
            flash.now[:notice] = "Pousada não alterada."
            render :new, status: 422
        end
     end

    def cities
        @active_inns_by_city = Inn.where(status: "ativa", city: params[:city])
        names = []
        @active_inns_by_city.each do |name| 
            names << name.trade_name
        end
        @active_inns_by_city = @active_inns_by_city.order(:trade_name)
    end

    def search
        @query = params['query']
        @inns = Inn.where("trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ? ", "%#{@query}%", "%#{@query}%", "%#{@query}%")
    end

    def advanced_search
        @inns = Inn.all
    end

    def advanced_search_results
        @inns = Inn.joins(:rooms).where("pet = ? AND (trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ?) AND rooms.tv = ? AND rooms.accessible = ? AND rooms.air_conditioner = ?", params['pet'], "%#{params['query']}%", "%#{params['query']}%", "%#{params['query']}%", params['tv'], params['accessible'], params['air_conditioner'])
    end

    def reservations
        @inn = Inn.find_by(owner_id: current_owner)
        @rooms = @inn.rooms
        
    end

    def stay_list
        @inn = Inn.find_by(owner_id: current_owner)
        @rooms = @inn.rooms
        
    end


    def reviews_list
        @inn = Inn.find_by(owner_id: current_owner)
        @reviews = Review.joins(reservation: { room: :inn }).where(inns: { id: @inn.id })
    end

    private

    def inn_params
        inn_params = params.require(:inn).permit(:trade_name, :company_name, :registration_number, :phone, :email, :address, :neighborhood, :city, :zip_code, :description, :pet, :rules, :check_in, :check_out, :status, :payment_methods)
    end

    def set_inn
        @inn = Inn.find(params[:id])
    end

    def cant_edit

        redirect_to root_path unless @inn.owner_id == current_owner.id
    end

end