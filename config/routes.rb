Rails.application.routes.draw do

  devise_for :users, format: false

  resources :users, only: [:show], format: false do
    resources :tweets, format: false
    resources :relationships, param: :following_user_id, only: [:index], format: false
  end

  resources :relationships, param: :following_user_id, only: [:create, :destroy], format: false

  root to: 'home#index'
end
