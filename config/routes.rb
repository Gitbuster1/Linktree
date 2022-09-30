Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'profile', to: 'dashboard#profile'
  get ':id', to: 'dashboard#show', as: :user

end
