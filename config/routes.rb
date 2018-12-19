Rails.application.routes.draw do

  root "welcome#index"

  resources :welcome, only: :index

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/profile', to: "users#profile", as: "profile"
  get '/profile/:id/edit', to: "users#edit", as: "edit_profile"
  post '/profile', to: "users#update"

  resources :items
  resources :users, only:[:show, :create, :update]
  resources :merchants
  resources :orders
  resources :cart, only: [:index]
end
