require "sidekiq/web"
Rails.application.routes.draw do
  default_url_options :host => "hrbrails.herokuapp.com"
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    username == ENV["SIDEKIQ_USER_NAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
  mount(Sidekiq::Web => "/sidekiq")

  root "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  } 
  
  resources :features
  resources :categories
  resources :rooms
  get 'dashboard', to: 'dashboard#index'
  post 'rooms/available', to: 'home#available_rooms', as: 'available_rooms'
  get 'reservation/:room_category', to: 'home#reservation', as: 'room_reservation'
  get 'booking/reservation_confirmation/:booking_id', to: 'bookings#reservation_confirmation', as: 'reservation_confirmation'
  get 'bookings', to: 'bookings#index'
  get 'bookings/all', to: 'bookings#all'
  post 'booking/new', to: 'bookings#new', as: 'new_room_booking'
  get 'booking/:booking_id', to: 'bookings#show', as: 'show_booking'
  get 'booking/:booking_id/cancellation', to: 'bookings#cancellation', as: 'cancel_booking'

  # post 'category', to: 'category#create', as: 'categories'
  # get 'category/:id/edit', to: 'category#edit', as: 'edit_category'
  # get 'category/:id', to: 'category#show', as: 'show_category'
  # put 'category/:id', to: 'category#update'
  # patch 'category/:id', to: 'category#update'
  # delete 'category/:id', to: 'category#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end
