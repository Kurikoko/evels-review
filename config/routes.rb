Rails.application.routes.draw do
  devise_for :users
  root to: "places#index"
  resources :places, only: [:index, :new, :create, :show] do
    resources :reviews, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :users, only: [:show]
end
