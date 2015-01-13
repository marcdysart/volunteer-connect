Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:update, :show, :index]
  resources :posts
  get 'welcome/index'

  get 'about' => 'welcome#about'
  get 'profile' => 'welcome#about'
  get 'search' => 'welcome#search'

    root to: 'welcome#index'
end
