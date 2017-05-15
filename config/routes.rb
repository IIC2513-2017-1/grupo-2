Rails.application.routes.draw do

  get "/cart", to: "users#show_cart", as: "cart"
  post "/carts", to: "users#add_to_cart", as: "update_cart"
  delete "/users/:user_id/cart/:id", to: "users#destroy_cart", as: "destroy_cart"

  resources :categories, :except => :show
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :purchases, only: [:show, :create, :destroy]
  resources :products do
    resources :comments, :except => [:show, :new, :index]
  end

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
