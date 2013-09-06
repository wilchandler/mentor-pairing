MentorPairing::Application.routes.draw do
  get "/activations/:code/user", :to => "activations#user"
  get "/appointments/:code/create", :to => "appointments#create"
  get '/sign_in', :to => 'sessions#new', :as => :sign_in
  get '/auth/:provider/callback', :to => 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/sign_out', :to => 'sessions#destroy', :as => :sign_out

  root :to => "availabilities#index"

  resources :availabilities
  resources :users
  resources :appointment_requests
end
