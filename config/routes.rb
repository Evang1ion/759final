Rails.application.routes.draw do
  get "order_items/create"
  get "order_items/destroy"
  get "users/new"
  get "users/create"
  get "users/show"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  resources :users, only: [:new, :create, :show]

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :order_items, only: [:create, :destroy]
  resources :orders, only: [:show]

  resources :restaurants, only: [:index, :show] do
    resources :menu_items, only: [:index]
  end

  resources :orders, only: [:new, :create, :show]

  root 'restaurants#index'
end
