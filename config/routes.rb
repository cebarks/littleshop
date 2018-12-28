Rails.application.routes.draw do
  root "welcome#index"

  resources :welcome, only: :index

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :admin do
    # resources :users, only: [:show, :update], as: "merchants"
    resources :users, only: [:index, :show, :update], as: "users"
    resources :merchants, only: [:index, :show, :update]
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
  get '/dashboard/items', to: 'merchants#items'

  resources :items, only: [:index, :show, :new, :edit, :destroy]
  resources :orders, only: [:index]

  get '/cart', to: "carts#show"
  post '/cart', to: "carts#create", as: "carts"
  delete '/cart', to: "carts#destroy", as: "empty_cart"
  patch '/cart', to: "carts#update", as: "remove_item"
end
