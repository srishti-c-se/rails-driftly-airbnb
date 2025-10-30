Rails.application.routes.draw do
  get '/conversations', to: 'conversations#index'
  get '/conversations/:id', to: 'conversations#show'
  post '/users/:id/contact', to: 'conversations#create'
  root to: "pages#home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # User can view all vehicles
  get "/vehicles", to: "vehicles#index"
  # User can view details of 1 vehicle and search for 1 specific vehicle
  get "/vehicles/:id", to: "vehicles#show", as: :vehicle
  # Renter can register new vehicle
  get "/vehicles/new", to: "vehicles#new", as: :new_vehicle
  post "/vehicles", to: "vehicles#create"
  # Renter can update vehicle details
  get "/vehicles/:id/edit", to: "vehicles#edit", as: :edit_vehicle
  patch "/vehicles/:id", to: "vehicles#update"
  # Renter can delete a vehicle listing
  delete "vehicles/:id", to: "vehicles#destroy"
  # User can view vehicles near his location
  get "/vehicles/nearby", to: "vehicles#nearby"
end
