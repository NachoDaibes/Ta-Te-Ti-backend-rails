Rails.application.routes.draw do
  resources :users do
    collection do
      get :current
      post :login
    end

    member do
      post :create
    end
  end


  
  post "/boards", to: "boards#create"
  post "/boards/:id/new_game", to: "boards#new_game"
  get "/boards", to: "boards#index"
  put "/boards/:id/new_move", to: "boards#new_move"

end
