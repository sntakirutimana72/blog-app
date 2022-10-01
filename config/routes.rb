Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :users, only: :show do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: :create
    end
  end

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#create'
      resources :users, only: [] do
        resources :posts, only: :index do
          resources :comments, only: :index
        end
      end
      resources :posts, only: [] do
        resources :comments, only: :create
      end
    end
  end
end
