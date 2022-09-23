Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  } 
  resources :features
  resources :categories
  resources :rooms
  post 'rooms/available', to: 'home#available_rooms', as: 'available_rooms'
  get 'reservation/:room_category', to: 'home#reservation', as: 'room_reservation'
  post 'booking/new', to: 'bookings#new', as: 'new_room_booking'
  # get 'category/new', to: 'category#new'
  # post 'category', to: 'category#create', as: 'categories'
  # get 'category/:id/edit', to: 'category#edit', as: 'edit_category'
  # get 'category/:id', to: 'category#show', as: 'show_category'
  # put 'category/:id', to: 'category#update'
  # patch 'category/:id', to: 'category#update'
  # delete 'category/:id', to: 'category#destroy'
  # get 'category' as 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end
