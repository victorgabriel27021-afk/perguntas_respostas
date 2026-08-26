Rails.application.routes.draw do
  namespace :admin do
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]

  get "questions", to: "questions#index"
  get "dashboard", to: "dashboard#index"

  resources :users, only: [:index, :show, :edit, :update, :destroy]
  patch "users/:id", to: "users#update", as: :update_user
  delete "users/:id", to: "users#destroy", as: :delete_user
  patch "users/:id/toggle_admin", to: "users#toggle_admin", as: :toggle_admin_user
end

  devise_for :users

  root "questions#index"

  get "my_questions", to: "questions#my_questions"

  get "/dashboard", to: "users/dashboard#index", as: :dashboard

  namespace :users do
    get "/profile", to: "profile#show", as: :profile
    get "/profile/edit", to: "profile#edit", as: :edit_profile
    patch "/profile", to: "profile#update"
  end

  resources :questions, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :answers, only: [:create]
  end

  post "answers/:id/vote", to: "answers#vote", as: :vote_answer

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end