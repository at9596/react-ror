Rails.application.routes.draw do
  

  # Defines the root path route ("/")
  root "tasks#index"
  resources :users, only: [:create] do
    collection do
      post :login
    end
  end
  resources :tasks do
    collection do
      get :completed
      get :search
    end
  end
end
