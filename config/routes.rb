Rails.application.routes.draw do
  devise_for :users
  get 'uploads/index'
  root to: "uploads#index"
  resources :uploads
  resources :users, only: [:show, :edit, :update]
end
