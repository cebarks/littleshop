Rails.application.routes.draw do

  root "welcome#index"

  resources :welcome, only: :index

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/profile', to: "users#profile", as: "profile"
  post '/login', to: 'sessions#create'

  resources :items
  resources :users, only:[:show, :edit, :update, :create]
  resources :merchants
  resources :orders
  resources :cart, only: [:index]
end
