Rails.application.routes.draw do
  get 'users/index'

  get 'users/edit'

  get 'users/update'

  get 'sites/home'

  resources :forms, param: :slug, format: :json

  root 'sites#home'
end
