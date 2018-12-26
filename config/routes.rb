Rails.application.routes.draw do
  root "welcome#index"

  resources :welcome, only: :index

  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users, only: [:show, :update], as: "merchants"
    resources :users, only: [:index, :show], as: "users"
  end

  resources :users, only: [:update, :create]
  get '/register', to: "users#new"
  get '/profile', to: "users#show", as: "profile"
  get '/profile/edit', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'
  get '/profile/orders/:order_id', to: 'orders#show', as: 'profile_order'

  get '/merchants', to: 'users#index'
  resources :users, only: [], shallow: false, as: 'profile' do
    resources :orders, only: [:index]
  end

  get '/dashboard', to: 'merchants#dashboard'

  resources :items, only: [:index, :show]

  get '/cart', to: "carts#show"
  post '/cart', to: "carts#create", as: "carts"
end
