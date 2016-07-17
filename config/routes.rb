Rails.application.routes.draw do

  devise_for :users, skip: %i(password), format: false

  resources :users, only: %i(show), format: false do
    member do
      get :following
      get :followers
      get :search, controller: :searches
    end
    resources :tweets, format: false do
      resource :likes, only: %i(create destroy), format: false do
        collection do
          get :users_list, format: false
        end
      end
      resources :comments, only: %i(index create destroy), format: false
    end
    resource :relationships, only: %i(create destroy), format: false
  end

  match '/cable', :to => ActionCable.server, via: %i(get post)

  root to: 'home#index'
end
