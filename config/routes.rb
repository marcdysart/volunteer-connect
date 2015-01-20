Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:update, :show, :index]
  resources :posts, only: [:index] do
    resources :locations, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]

  end
  resources :posts, except: [:index] do
    resources :locations, only: [:create, :destroy]
  end

  resources :locations

  get 'welcome/index'

  get 'about' => 'welcome#about'
  get 'profile' => 'welcome#profile'
  get 'search' => 'welcome#search'

    root to: 'welcome#index'
end
