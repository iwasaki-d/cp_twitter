Rails.application.routes.draw do

  resources :twitter
  devise_for :users
  resources :users, only: [:show]

  root to: 'home#index'
end
