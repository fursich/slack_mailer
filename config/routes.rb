Rails.application.routes.draw do
  root to: 'users#index'
  resources :users
  resources :user_sessions, only: :create

  get    :login,  to: 'user_sessions#new',     as: :login
  delete :logout, to: 'user_sessions#destroy', as: :logout

end
