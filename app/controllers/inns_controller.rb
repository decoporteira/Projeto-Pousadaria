class InnsController < ApplicationController
    def new
        @inn = Inn.new
    end

    def create
        
        inn_params = params.require(:inn).permit(:trade_name, :company_name, :registration_number, :phone, :email, :address, :neighborhood, :city, :zip_code, :description, :payment_methods, :pet, :rules, :check_in, :check_out, :status)
        @inn = Inn.new(inn_params)
        @inn.user = current_user
        if @inn.save()
           redirect_to root_path, notice: "Pousada cadastrada com sucesso."
        else
           flash.now[:notice] = "Pousada não cadastrada."
           render 'new'
        end
    end
end