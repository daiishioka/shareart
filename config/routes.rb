Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'about', to: 'about#show'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :followings, :followers, :likes
    end
  end
  
  resources :artposts, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
