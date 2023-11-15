class InnsController < ApplicationController
    before_action :authenticate_owner!, only: [:edit]
    before_action :set_inn, only: [:show, :edit, :update] 
    before_action :cant_edit, only: [:edit, :update, :destroy]

 
    def new
        @inn = Inn.new
    end

    def index
        current_owner
        @inn = Inn.find_by(owner_id: current_owner.id) 
    end

    def show
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
        @inn.update(inn_params)
        if @inn.save()
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
        @active_inns_by_city = @active_inns_by_city.sort_by { |element| element[:trade_name] }
    end

    def search
        @query = params['query']
        @inns = Inn.where("trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ? ", "%#{@query}%", "%#{@query}%", "%#{@query}%")
    end

    def advanced_search
        @inns = Inn.all
    end

    
    def advanced_search_results
        @inns = Inn.where("pet = ? AND (trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ?) ", params['pet'], "%#{params['query']}%", "%#{params['query']}%", "%#{params['query']}%")
    end

    private

    
    def inn_params
        inn_params = params.require(:inn).permit(:trade_name, :company_name, :registration_number, :phone, :email, :address, :neighborhood, :city, :zip_code, :description, :payment_methods, :pet, :rules, :check_in, :check_out, :status, )
    end

    def set_inn
        @inn = Inn.find(params[:id])
    end

    def cant_edit
        current_owner.id
        redirect_to root_path unless @inn.owner_id == current_owner.id
    end
end