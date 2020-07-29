Rails.application.routes.draw do
  get '/home', to: 'movies#home'

  resources :users, only: [:index, :show, :update, :create, :new, :destroy] do
    member do
      get 'movies', to: 'users#get_movies'
      get 'reviews', to: 'users#get_reviews'
    end
  end
  get '/users/show_current_user', to: 'users#show_current_user'
  post '/users/login', to: 'users#login'
  post '/users/logout/:id', to: 'users#logout'

  get '/search', to: 'movies#search'
  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      put 'rate', to: 'user_movies#rate'
    end
  end

  resources :reviews, only: [:create, :update, :destroy]
end
