Rails.application.routes.draw do
  get "admin/customers" => "admin/customers#index", as: "admin_customers"
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
    
  }
  namespace :admin do
    root to: "homes#top"
    resources :items
    resources :customers, only: [:show, :edit, :update, :index]
    resources :orders, only: [:show]
  end
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  
  }
  
  scope module: :public do
    root to: "homes#top"
    get "homes/about" => "homes#about"
    get "customers/mypage"=> 'customers#show', as: 'customers_mypage'
    get "customers/confirmation"=> 'customers#confirmation', as: 'customers_confirmation'
    post "orders/confirmation" => "orders#confirmation"
    get "orders/completion" => "orders#completion"
    resources :items 
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_item'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    resources :customers, only: [:edit, :update]
    resources :orders, only: [:show,:new, :index, :create]
    patch '/withdrawal', to: 'customers#withdrawal', as: 'withdrawal'
    
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
