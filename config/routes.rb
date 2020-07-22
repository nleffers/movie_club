Rails.application.routes.draw do
  get '/', to: 'homepage#home', as: 'root'

  resources :users, only: [:index, :show, :update, :create, :new, :destroy] do
    member do
      get 'movies', to: 'users#get_movies'
      get 'reviews', to: 'users#get_reviews'
    end
  end
  get '/users/show_current_user', to: 'users#show_current_user'
  post '/users/login', to: 'users#login'
  post '/users/logout/:id', to: 'users#logout'

  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      put 'rate'
    end
  end

  resources :reviews, only: [:create, :update, :destroy]
end
