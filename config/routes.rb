Rails.application.routes.draw do
  root to: 'users#index'
  resources :users
  resources :user_sessions, only: :create

  get    :login,  to: 'user_sessions#new',     as: :login
  delete :logout, to: 'user_sessions#destroy', as: :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
