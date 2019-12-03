Rails.application.routes.draw do

  resources :users
  resources :sessions, only: [:create]

  get 'signup', to: 'users#new', as: 'signup'
  get 'show_qr', to: 'users#show_qr', as: 'show_qr'
  post 'qr_setup', to: 'users#qr_setup', as: 'qr_setup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
