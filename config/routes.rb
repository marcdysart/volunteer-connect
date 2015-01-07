Rails.application.routes.draw do
  get 'welcome/index'

  get 'about' => 'welcome#about'
  get 'profile' => 'welcome#about'

    root to: 'welcome#index'
end
