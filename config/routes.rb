Rails.application.routes.draw do
  resources :products
  root to: "home#index"

  constraints Clearance::Constraints::SignedIn.new do
    root to: "products#index", as: :signed_in_root
  end

  get 'about' => 'home#about', as: 'about'
end
