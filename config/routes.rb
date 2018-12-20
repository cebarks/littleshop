Rails.application.routes.draw do
  root "welcome#index"

  resources :welcome, only: :index

  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:update, :create]
  get '/register', to: "users#new"
  get '/profile', to: "users#show", as: "profile"
  get '/profile/edit', to: 'users#edit'
  get '/merchants', to: 'users#index'

  get '/dashboard', to: 'merchants#dashboard'

  resources :items, only: [:index, :show]
  resources :orders, only: [:index]

  get '/cart', to: "carts#show"
  post '/cart', to: "carts#create", as: "carts"
end
