Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'users'}
 
  resources :stores, except: [:index, :show]
  post 'stores/:id', to: 'categories#create'
  post 'stores/:id/edit', to: 'categories#create'

  resources :categories, except: [:new, :create, :index, :show]
  resources :items, except: [:index, :new, :create, :show, :update]
  get 'new_item/:id', to: 'items#new'
  post 'new_item/:id', to: 'items#create'
  post 'items/:id/edit', to: 'items#update'
 

  get 'users', to: 'users#index'
  get 'users/edit/:id', to: 'users#edit'
  post 'users/edit/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  resources :store_assignment, only: [:create, :destroy]

  get 'users/:id', to: 'stores#index'

  get 'stores/:id', to: 'stores#show'

  resources :carts
  get 'add_to_cart', to: 'carts#add_to_cart'
  get 'remove_from_cart', to: 'carts#remove_from_cart'
  get 'remove_item_from_cart', to: 'carts#remove_item_from_cart'
  get 'empty_cart', to: 'carts#empty_cart'
  get 'generate_receipt', to: 'receipts#generate_receipt'
  get 'checkout', to: 'receipts#checkout'
  get 'store_orders', to: 'stores#orders'
  get 'user_orders', to: 'users#orders'
  get 'orders', to: 'welcome#orders'
  # all your other routes
  match '*unmatched', to: 'application#not_found_method', via: :all

  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
