Rails.application.routes.draw do
  devise_for :users, :controllers => {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
      get '/users/sign_in'  => 'devise/sessions#new'
    end
    post 'accounts/otp_verification', to: 'accounts#otp_verification'
  
    resources :interests, only: [:create, :new, :index]
    resources :qualifications, only: [:create, :new, :index]
    resources :academics, only: [:index, :create, :update, :destroy]
    resources :users, only: [:show]
end


