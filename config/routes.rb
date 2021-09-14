# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'uploads#index'
  get 'uploads/category', to: 'uploads#category'
  resources :uploads do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end


  resources :users, only: [:show, :edit, :update] do
    member do
      get :following, :followers, :favorites
    end
    get '/mypage' => 'users#mypage'
    get '/mypage/uploads' => 'users#tables'
    get '/mypage/favorites' => 'users#favorites'
  end

  resources :relationships, only: [:create, :destroy]

  namespace :api, { format: 'json' } do
    resources :favorites, only: [:index, :create, :destroy]
    resources :relationships, only: [:index, :create, :destroy]
  end

end
