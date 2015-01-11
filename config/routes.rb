Rails.application.routes.draw do
  get 'posts/index'

  get 'posts/show'

  get 'posts/new'

  get 'posts/edit'

  devise_for :users
  get 'welcome/index'

  get 'about' => 'welcome#about'
  get 'profile' => 'welcome#about'

    root to: 'welcome#index'
end
