Rails.application.routes.draw do
  get '/', to: 'homepage#home', as: 'root'

  resources :users, only: [:index, :show, :update, :create, :new, :destroy]
  get '/users/show_current_user', to: 'users#show_current_user'

  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      put 'rate'
    end
  end
end
