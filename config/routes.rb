Rails.application.routes.draw do
  get 'comments/create'
  resources :profiles
  mount Notifications::Engine => "/notifications"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
  end
  namespace :mentor do
    resources :users
    resources :messages
    resources :conversations
  end
  root 'sessions#new'
  resources :conversations do
    resources :messages
  end
  resources :profiles do
    resources :comments
  end
end
