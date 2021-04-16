Rails.application.routes.draw do
  get 'upload/index'
  root to: "upload#index"
end
