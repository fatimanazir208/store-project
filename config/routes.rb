Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users'}
  root 'welcome#index'
  resources :stores
  resources :categories, except: [:new, :create, :index]
  get 'stores/create_category/:store_id', to: 'categories#new'
  post 'stores/create_category/:store_id', to: 'categories#create'
  resources :items, except: [:new, :create, :index]
  get 'categories/create_item/:category_id', to: 'items#new'
  post 'categories/create_item/:category_id', to: 'items#create'
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  get 'users/edit/:id', to: 'users#edit'
  post 'users/edit/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  resources :store_assignment, only: [:create, :destroy]
  get 'users/stores/:id', to: 'stores#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
