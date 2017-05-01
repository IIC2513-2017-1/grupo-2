Rails.application.routes.draw do

  get "/users/:id/cart", to: "users#show_cart", as: "cart"
  post "/users/:id/cart", to: "users#add_to_cart", as: "update_cart"

  get "/users/:user_id/purchases/:id", to: "purchases#show", as: "show_purchase"
  post "/users/:user_id/purchases", to: "purchases#create"
  resources :categories, :except => :show
  resources :users
  resources :products do
    resources :comments, :except => :show
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
