Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'profile', to: 'dashboard#profile'
  get ':id', to: 'dashboard#show', as: :user
  patch 'links/:id', to: 'links#update', as: :links
  post 'links', to: 'links#create', as: :create_links
  delete 'links/:id', to: 'links#destroy', as: :destroy_links
end
