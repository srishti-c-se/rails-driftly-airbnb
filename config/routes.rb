Rails.application.routes.draw do
  namespace :owner do
    get 'bookings/index'
  end
  root to: "vehicles#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #vehicles
  # User can view all vehicles
  get "/vehicles", to: "vehicles#index"
  # Renter can register new vehicle
  get "/vehicles/new", to: "vehicles#new", as: :new_vehicle
  # User can view details of 1 vehicle and search for 1 specific vehicle
  get "/vehicles/:id", to: "vehicles#show", as: :vehicle
  post "/vehicles", to: "vehicles#create"
  # Renter can update vehicle details
  get "/vehicles/:id/edit", to: "vehicles#edit", as: :edit_vehicle
  patch "/vehicles/:id", to: "vehicles#update"
  # Renter can delete a vehicle listing
  delete "vehicles/:id", to: "vehicles#destroy", as: :destroy_vehicle
  # User can view vehicles near his location
  get "/vehicles/nearby", to: "vehicles#nearby"

  # bookings
  # As a user, I can see my bookings (past & upcoming).
  get "/bookings", to: "bookings#index" , as: :bookings
  # As a user, I can see a booking page.,
  get "/bookings/:id", to: "bookings#show", as: :booking
  # As a user, I can start a new booking on a vehicle.
  # get "/vehicles/:vehicle_id/bookings/new", to: "bookings#new", as: :new_vehicle_booking
  # post "/bookings", to: "bookings#create"
  # post "/vehicles/:vehicle_id/bookings/new", to: "bookings#create"
  # post "/vehicles/:vehicle_id/bookings", to: "bookings#create"

  get    '/vehicles/:vehicle_id/bookings/new', to: 'bookings#new', as: :new_vehicle_booking
  post   '/vehicles/:vehicle_id/bookings',     to: 'bookings#create', as: :vehicle_bookings


  # As a user, I can cancel my booking (if allowed)
  # get "/bookings/:id/cancel", to: "bookings#cancel"
  patch "bookings/:id/cancel", to: "bookings#cancel",  as: :cancel_booking
  # post "/bookings/:id", to: "bookings#cancel", as: :cancel_booking
  # As a host, I can accept a booking request.
  patch "bookings/:id/accept", to: "bookings#accept", as: :accept_booking
  # As a host, I can reject a booking request.
  patch "bookings/:id/reject", to: "bookings#reject",  as: :reject_booking
  # As a host, I can see bookings for my vehicles.
  get "/owner/bookings", to: "owner/bookings#index"
  resources :vehicles do
    resources :reviews, only: [:index, :create]
    # get  '/vehicles/:vehicle_id/reviews', to: 'reviews#index', as: :vehicle_reviews
    # post '/vehicles/:vehicle_id/reviews', to: 'reviews#create'
  end
end
