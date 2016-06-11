Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] do
    resources :twitter
  end

  root to: 'home#index'
end
