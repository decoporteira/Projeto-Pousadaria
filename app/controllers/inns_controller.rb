class InnsController < ApplicationController
    before_action :authenticate_user!, only: [:edit]
    before_action :set_inn, only: [:show, :edit, :update] 
    before_action :cant_edit, only: [:edit, :update, :destroy]

 
    def new
        @inn = Inn.new
    end

    def index
        current_user
        @inn = Inn.find_by(user_id: current_user.id) 
        # if @inn.trade_name.length < 1
        #     redirect_to root_path
        # end
    end
    def show
      
    end

    def edit
        
    end

    def create  
        @inn = Inn.new(inn_params)
        @inn.user = current_user
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
        p @active_inns_by_city = names.sort
    end

    private

    def inn_params
        inn_params = params.require(:inn).permit(:trade_name, :company_name, :registration_number, :phone, :email, :address, :neighborhood, :city, :zip_code, :description, :payment_methods, :pet, :rules, :check_in, :check_out, :status)
    end

    def set_inn
        @inn = Inn.find(params[:id])
    end

    def cant_edit
        current_user.id
        redirect_to root_path unless @inn.user_id == current_user.id
    end
end