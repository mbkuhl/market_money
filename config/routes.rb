Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/api/v0/markets/search", to: "api/v0/markets/search#index"
  
  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index], controller: 'markets/vendors'
        resources :search, only: [:index], controller: 'markets/search'
        resources :nearest_atms, only: [:index], controller: 'markets/nearest_atms'
      end
      resources :vendors, only: [:show, :create, :destroy, :update]
      resources :market_vendors, only: [:create]
    end
  end

  delete "/api/v0/market_vendors", to: "api/v0/market_vendors#destroy"

end
