Rails.application.routes.draw do
  get 'bookmarks/index'
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  get 'vehicles/index'
  get 'vehicles/show'
  get 'vehicles/new'
  get 'vehicles/create'
  get 'vehicles/edit'
  get 'vehicles/update'
  get 'vehicles/destroy'
  get 'vehicles/nearby'
  root to: "pages#home"
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

  # bookings
  # As a user, I can see my bookings (past & upcoming).
  get "/bookings", to: "bookings#index"
  # As a user, I can see a booking page.
  get "/bookings/:id", to: "bookings#show"
  # As a user, I can start a new booking on a vehicle.
  get "/vehicles/:vehicle_id/bookings/new", to: "bookings#new"
  post "/vehicles/:vehicle_id/bookings", to: "bookings#create"
  # As a user, I can cancel my booking (if allowed)
  patch "bookings/:id/cancel", to: "bookings#cancel"
  # As a host, I can accept a booking request.
  patch "bookings/:id/accept", to: "bookings#accept"
  # As a host, I can reject a booking request.
  patch "bookings/:id/reject", to: "bookings#reject"
  # As a host, I can see bookings for my vehicles.
  get "/owner/bookings", to: "owner/bookings#index"
end
