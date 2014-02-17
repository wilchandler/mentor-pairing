MentorPairing::Application.routes.draw do
  get "/activations/:code/user", :to => "activations#user"
  get "/appointments/:code/create", :to => "appointments#create"
  get "/appointments/:user_code/feedback",
    :to => "appointments#feedback", :as => "new_appointment_feedback"
  post "/appointments/:user_code/feedback",
    :to => "appointments#accept_feedback", :as => "appointment_feedback"
  post "/users/findmentor", :to => "users#find_mentor"
  root :to => "availabilities#index"

  resources :availabilities
  resources :users
  resources :appointment_requests
end
