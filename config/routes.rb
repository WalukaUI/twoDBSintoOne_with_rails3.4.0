Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  resources :comments
  resources :appointments
  resources :doctor_locations
  resources :doctors
  resources :locations
  resources :patients
  resources :users
  resources :departments
  resources :cities
  resources :countries, only: [ :show, :index ]

    # ,only: [ :show, :index ]
    post "/signuppatient", to: "patients#create"
    post "/signupdoctor", to: "doctors#create"
    post "/signup", to: "users#create"
    get "/c&c/me", to: "users#show"
    get "/me", to: "patients#show"
    get "/doc", to: "doctors#sessionshow"
    post "/login", to: "sessions#create"
    delete "/me/logout", to: "sessions#me_destroy"
    delete "/doc/logout", to: "sessions#doc_destroy"
    delete "/cnc/logout", to: "sessions#cnc_user_destroy"

    resources :locations do
      resources :doctors, only: [ :show, :index ]
    end

    resources :doctors do
      resources :locations, only: [ :show, :index ]
      resources :patients, only: [ :show, :index ]
      resources :appointments, only: [ :show, :index ]
    end

    resources :patients do
      resources :doctors, only: [ :show, :index ]
      resources :appointments, only: [ :show, :index ]
    end

    resources :employees do
      resources :projects, only: [ :show, :index ]
    end

    resources :projects do
      resources :employees, only: [ :show, :index ]
    end
  # Defines the root path route ("/")
  # root "posts#index"
end
