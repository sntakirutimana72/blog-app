Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: :show do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: :create
      resources :likes, only: :create
    end
  end
end
