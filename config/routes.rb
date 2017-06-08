Rails.application.routes.draw do
  post 'logins/create'
  get 'sessions/create', :login
  delete 'sessions/destroy', :logout

  resources :users, only: [:index, :edit, :update] do
    post :impersonate, on: :member
  end
  resources :campaigns
  resources :forms, param: :slug, format: :json
  resources :form_elements, only: [:edit, :update]

  get 'sites/home'

  root 'sites#home'
end
