Rails.application.routes.draw do
  devise_for :users
  root 'users#index', as: 'home'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
    end
  end

  resources :likes, only: %i[create]

  namespace :api do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[index new create destroy]
    end
  end
end
