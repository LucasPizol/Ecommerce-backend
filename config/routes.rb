Rails.application.routes.draw do
  resource :users, only: [:create]
  resources :payments

  post "/login", to: "users#login"
  get "/products", to: "products#show"
  post "/checkout", to: "payments#create"

  get "up" => "rails/health#show", as: :rails_health_check

end
