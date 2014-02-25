MentorPairing::Application.routes.draw do
  get "/activations/:code/user", :to => "activations#user"
  get "/appointments/:code/create", :to => "appointments#create"
  get "/appointments/:user_code/feedback",
    :to => "appointments#feedback", :as => "new_appointment_feedback"
  post "/appointments/:user_code/feedback",
    :to => "appointments#accept_feedback", :as => "appointment_feedback"
  post "/users/findmentor", :to => "users#find_mentor"
  root :to => "availabilities#index"

  get "/weekly", :to => "metrics#weekly", :as => "weekly_metrics"

  resources :availabilities
  resources :users do
    member do
      get :feedback
    end
  end
  resources :appointment_requests
end
