Rails.application.routes.draw do
  devise_for :guests
  devise_for :owners
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root to: "home#index"
  resources :inns, only: [:new, :create, :index, :show, :edit, :update] do 
    get 'show_reservation', on: :member
    get 'cities', on: :collection
    get 'search', on: :collection
    get 'advanced_search', on: :collection
    get 'advanced_search_results', on: :collection
    get 'reservations', on: :collection
    get 'stay_list', on: :collection
    get 'reviews_list', on: :collection
  end
  resources :rooms, only: [:new, :create, :index, :show, :edit, :update, :destroy]  do
    get 'pre_reservation', on: :member
    resources :reservations, only: [:new, :create, :show] do
      resources :reviews, only: [:new, :create, :show, :edit, :update]
      get 'check', on: :collection
      get 'stay', on: :member
      get 'confirm', on: :collection
      post 'validates', on: :collection
      post 'cancel_reservation', on: :member
      post 'cancel_reservation_by_owner', on: :member
      post 'check_out', on: :member
      post 'check_in', on: :member                              
      
    end
   
  end
  
  resources :prices, only: [:new, :create, :show, :edit, :update, :destroy] 
  get 'list', to: 'reservations#list'
  namespace :api do
    namespace :v1 do
      resources :inns, only: [:index] do
        get 'rooms', on: :collection
        get 'inn_details', on: :collection
        get 'room', on: :collection
       
      end
    end
  end
end
