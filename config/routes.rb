Rails.application.routes.draw do
  root "home#index"

  get "shopper/sign_up" => "applicants#new", as: :register

  get "shopper/login" => "sessions#new", as: :login
  post "shopper/login" => "sessions#create"
  post "shopper/logout" => "sessions#logout", as: :logout

  resources :applicants, only: %i(create edit update), path: "shoppers" do
    collection do
      get :background
      post :authorize, path: "authorize"
      get :confirm
    end
  end
  resources :funnels, only: [:index]
end
