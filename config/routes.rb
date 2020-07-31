Rails.application.routes.draw do
  get '/home', to: 'movies#home'

  resources :users, only: [:show, :update, :create] do
    member do
      get 'movies', to: 'users#get_movies'
      get 'reviews', to: 'users#get_reviews'
      post 'logout', to: 'users#logout'
    end
  end
  post '/users/login', to: 'users#login'

  get '/search', to: 'movies#search'
  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      put 'rate', to: 'user_movies#rate'
    end
  end

  resources :reviews, only: [:create, :update, :destroy]
end
