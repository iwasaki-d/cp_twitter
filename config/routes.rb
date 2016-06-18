Rails.application.routes.draw do

  devise_for :users, format: false

  resources :users, only: [:show], format: false do
    member do
      get :following
      get :followers
    end
    resources :tweets, format: false
    resource :relationships, only: [:create, :destroy], format: false
  end

  root to: 'home#index'
end
