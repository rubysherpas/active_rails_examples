Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, except: [:index, :show]
    resources :users do
      member do
        patch :archive
      end
    end
  end

  devise_for :users
  root "projects#index"

  resources :projects, only: [:index, :show] do
    resources :tickets do
      collection do
        post :upload_file
      end
    end
  end
end
