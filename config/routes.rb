Rails.application.routes.draw do
  devise_for :users
  get 'upload/index'
  root to: "upload#index"
end
