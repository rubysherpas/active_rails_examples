Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, only: [:new, :create, :destroy]
  end
  devise_for :users
  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
