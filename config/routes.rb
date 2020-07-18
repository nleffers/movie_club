Rails.application.routes.draw do
  get '/', to: 'homepage#home', as: 'root'

  resources :users, only: [:index, :show, :update, :create, :new, :destroy]
  resources :movies, only: [:index, :show, :update, :create, :new] do
    member do
      put 'rate'
    end
  end
end
