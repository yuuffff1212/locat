# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: "uploads#index"
  resources :uploads do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    collection do
      get :favorites
    end
    get '/mypage' => 'users#mypage'
    get '/mypage/uploads' => 'users#tables'
    get '/mypage/favorites' => 'users#favorites'
  end


  namespace :api, { format: 'json' } do
    resources :favorites, only: [:index, :create, :destroy]
  end

end
