Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "tasks#index"
  resources :tasks
end
