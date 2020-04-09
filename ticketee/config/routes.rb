Rails.application.routes.draw do
  devise_for :users
  root "projects#index"

  resources :projects do
    resources :tickets
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
