Rails.application.routes.draw do
  
  devise_for :users
  
  # get 'users/show'
  # get 'users/edit'
  resources :users, only: [:index, :show, :edit, :update]
  
  # get 'books/index'
  # get 'books/show'
  resources :books, only: [:create, :index, :show, :edit, :destroy, :update]

  root to: "homes#top"
  
  get '/home/about', to: 'homes#about', as: 'about'

end