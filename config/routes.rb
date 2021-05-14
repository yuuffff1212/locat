Rails.application.routes.draw do
  devise_for :users
  get 'uploads/index'
  root to: "uploads#index"
  resources :uploads, only: [:index, :new, :create, :show, :destroy]
end
