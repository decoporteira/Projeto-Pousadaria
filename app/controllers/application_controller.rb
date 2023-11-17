class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_user_inn, only: [:index, :edit]
    before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_in_path_for(resource)
      if session[:has_pre_reservation].present?
        room_reservation_path = new_room_reservation_path(session[:room])
        session[:has_pre_reservation] = nil
        return room_reservation_path
      else
        super
      end
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
    end

    private 
    def check_user_inn
      if owner_signed_in?
        @inn = Inn.find_by(owner_id: current_owner.id)
        if @inn.nil?
          flash[:notice] = "Você não tem uma pousada cadastrada. Por favor, complete seu cadastro."
          redirect_to new_inn_path
        end
      else
        @all_active_inns = Inn.where(status: "ativa")
        @recent_inns =  @all_active_inns.last(3)
        @active_inns = @all_active_inns - @recent_inns
        cities = []
        @all_active_inns.each do |item|
           cities << item.city
        end
        @novas_cities = cities.uniq
      end

    end

end
