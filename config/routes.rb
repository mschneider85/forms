Rails.application.routes.draw do
  post 'logins/create'
  get 'sessions/create', :login
  delete 'sessions/destroy', :logout

  resources :users, only: [:index, :edit, :update]
  resources :forms, param: :slug, format: :json

  get 'sites/home'

  root 'sites#home'
end
