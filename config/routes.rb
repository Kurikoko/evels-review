Rails.application.routes.draw do
  devise_for :users
  root to: "places#index"
  resources :places, only: [:index, :new, :create]
  resources :user, only: [:show]
end
