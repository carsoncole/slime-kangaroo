Rails.application.routes.draw do
  resources :messages
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root to: "home#index"

  constraints Clearance::Constraints::SignedIn.new do
    root to: "products#index", as: :signed_in_root
  end

  get 'about' => 'home#about', as: 'about'
  get 'contact' => 'home#contact', as: 'contact'
  resources :products, only: :show
  resources :sessions
  resources :orders, only: %i[ new create ]
  resources :users, only: :show
  get 'cart' => 'orders#cart', as: 'cart'
  post 'add-to-cart' => 'orders#add_to_cart', as: 'add_to_cart'
  post 'remove-from-cart' => 'orders#remove_from_cart', as: 'remove_from_cart'
  get 'shipping' => 'orders#shipping', as: 'shipping'
  get 'checkout' => 'orders#checkout', as: 'checkout'

  namespace 'admin' do
    resources :products, except: :show
    resources :settings, :users
    resources :orders, except: %i[ new create ]
  end

end
