Rails.application.routes.draw do

  root "welcome#index"

  resources :welcome, only: :index

  get '/register', to: "users#new"
  get '/login', to: "sessions#new"
  get '/profile', to: "users#profile", as: "profile"
  post '/login', to: 'sessions#create'
  get '/dashboard', to: 'merchants#dashboard'
  get '/logout', to: 'sessions#destroy'

  resources :items, only: [:index, :show]
  resources :users, only:[:show, :edit, :update, :create]
  resources :orders, only: [:index]
  resources :merchants, only: [:index]
  resources :cart, only: [:index]
end
