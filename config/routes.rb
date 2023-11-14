Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

    root to: "home#index"
    resources :inns, only: [:new, :create, :index, :show, :edit, :update] do 
      get 'cities', on: :collection
      get 'search', on: :collection
      get 'advanced_search', on: :collection
      get 'advanced_search_results', on: :collection
    end
    resources :rooms, only: [:new, :create, :index, :show, :edit, :update, :destroy]  do
      post 'check_availability', on: :member
      get 'pre_reservation', on: :member
      post 'check_room', on: :member
      resources :reservations, only: [:new, :create]
    end
    resources :prices, only: [:new, :create, :show, :edit, :update, :destroy] 
 
end
