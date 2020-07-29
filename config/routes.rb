Rails.application.routes.draw do
  root 'blogs#index'
  # resources :blogs do
  #   collection do
  #     post :confirm
  #   end
  # end

  # 以下、編集にも確認画面を適用
  resources :blogs do
    collection do
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
