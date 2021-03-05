Rails.application.routes.draw do
  root to: "home#index"

  constraints Clearance::Constraints::SignedIn.new do
    root to: "products#index", as: :signed_in_root
  end

  get 'about' => 'home#about', as: 'about'
  resources :products, :settings
  resources :orders, except: %i[ new create ]
  get 'cart' => 'orders#cart', as: 'cart'
  post 'add-to-cart' => 'orders#add_to_cart', as: 'add_to_cart'
  post 'remove-from-cart' => 'orders#remove_from_cart', as: 'remove_from_cart'
end
