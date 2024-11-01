Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :apartments
  resources :cleaners
  get 'clients/search', to: 'clients#search', defaults: { format: :json }
  resources :clients
  resources :admins
  get 'admin/cleaners', to: 'admins#management_cleaners', as: 'admin_management_cleaners'
end
