Rails.application.routes.draw do

  devise_for :users, skip: [:password], format: false

  resources :users, only: [:show], format: false do
    member do
      get :following
      get :followers
      get :search, controller: :searches
    end
    resources :tweets, format: false do
      resource :likes, only: [:create, :destroy], format: false do
        collection do
          get :users_list, only: [:create, :destroy], format: false
        end
      end
      resources :comments, only: [:index, :create, :destroy], format: false
    end
    resource :relationships, only: [:create, :destroy], format: false
  end

  match '/cable', :to => ActionCable.server, via: [:get, :post]

  root to: 'home#index'
end
