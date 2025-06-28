Rails.application.routes.draw do
  root "recipets#index"
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # user関連
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  # recipet関連
  resources :recipets do
    resources :recipet_items, only: [ :edit, :update, :destroy ]
    collection do
      get :add_item
      post :add_item_from_edit
    end
  end

  resources :categories

end
