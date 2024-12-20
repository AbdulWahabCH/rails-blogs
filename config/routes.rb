Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [ :show ]
  resources :articles do
    resources :comments # , only: [ :create, :edit, :update, :show, :destory ]
  end

  resources :reactions, only: [ :create ] do
    collection do
      post "like"
      match "unlike", to: "reactions#unlike", via: [ :delete, :post ] # Accepts both DELETE and POST
    end
  end

  namespace :admin do
    resources :users, only: [ :index, :show, :update, :destroy ]
    resources :articles do
      post "send_warning", on: :member
    end
    resources :comments
    post "login", to: "sessions#create"
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "articles#index"
end
