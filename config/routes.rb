Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :users, controllers: { registrations: 'registrations'}
  get 'user_orders', to: 'users#orders'

  resources :stores do
    get 'orders', on: :member
  end

  resources :categories, only: [:create]

  resources :items, except: [:index, :show]

  resources :receipts, only: [:new, :show, :index]

  resources :carts, only: [] do
    member do
      get 'increment_item_to'
      get 'decrement_item_from'
      get 'remove_item_from'
      get 'empty'
    end
  end

  get 'add_to_cart', to: 'carts#add_to_cart'

  # all your other routes
  match '*unmatched', to: 'application#not_found_method', via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
