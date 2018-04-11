Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html

  # Simple page routing
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Default route generator for article CRUD functionality
  resources :articles

  # Users routes
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # Login/logout routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Categories routes
  resources :categories, except: [:destroy]
end
