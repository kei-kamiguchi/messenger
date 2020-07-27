Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
