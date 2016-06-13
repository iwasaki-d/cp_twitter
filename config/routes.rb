Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] do
    resources :tweets
  end

  root to: 'home#index'
end
