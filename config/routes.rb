RottenMangos::Application.routes.draw do

  get "reviews/new"
  get "reviews/create"
  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  root to: 'movies#index'
  
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

    namespace :admin do
      resources :users
        # post :impersonate
  end

end
