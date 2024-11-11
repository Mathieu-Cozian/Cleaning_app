Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :apartments
  resources :cleaners
  get 'clients/search', to: 'clients#search', defaults: { format: :json }
  resources :clients
  resources :admins

  scope :admin, module: :admins do
    resources :cleaners, only: [:index]
  end
  # Route for cleaners management under the admins controller
end