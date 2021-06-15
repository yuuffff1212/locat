Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    resources :favorites, only: [:index, :create, :destroy]
  end

  devise_for :users
  get 'uploads/index'
  root to: "uploads#index"
  resources :uploads
  resources :users, only: [:show, :edit, :update]

end
