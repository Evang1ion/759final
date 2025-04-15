# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  resources :restaurants do
    resources :menu_items, only: [:index]
  end

  resources :orders
  resources :order_items, only: [:create, :destroy]

  root "restaurants#index"

  namespace :api do
    post   "login",                    to: "sessions#create"
    get    "restaurants/:id/menu_items", to: "restaurants#menu_items"
    get    "menu_items/:id",          to: "menu_items#show"
    post   "order_items",             to: "order_items#create"
    delete "order_items/:id",         to: "order_items#destroy"
  end
  
end
