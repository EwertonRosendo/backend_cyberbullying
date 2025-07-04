Rails.application.routes.draw do
  get 'questions/schools', to: 'questions#schools'
  get "school_questions/:school", to: "questions#questions_by_school"
  get "user_answers/:user_id", to: "school_answers#user_already_answered"
  get "case_by_user/:user_id", to: "cases#case_by_user"
  get "users/school/:school", to: "users#users_by_school"
  resources :schools
  resources :school_answers
  resources :questions
  resources :cases
  post "sessions/create"
  get "sessions/destroy"
  resources :users
  resources :tickets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
