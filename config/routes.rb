Rails.application.routes.draw do
  resources :products
  root to: "home#index"

  constraints Clearance::Constraints::SignedIn.new do
    root to: "products#index", as: :signed_in_root
  end

  post 'add-to-cart' => 'products#add_to_cart', as: 'add_to_cart'
  get 'cart' => 'products#cart', as: 'cart'
  get 'about' => 'home#about', as: 'about'
  resources :settings
end
