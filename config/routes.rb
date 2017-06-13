Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
     registrations: "users/registrations",
     omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :blogs do
    resources :comments
    post :confirm, on: :collection
  end

  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  root 'top#index'
  resources :poems, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end
end
