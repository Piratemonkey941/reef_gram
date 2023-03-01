Rails.application.routes.draw do
  get 'profiles/index'
  
  resources :likes, only: [:create, :destroy]
  resources :comments

  
  devise_scope :user do
    get '/users',           to: 'devise/registration#new'
    get '/users/password',  to: 'devise/passwords#new'
    get '/users/sign_out'   => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]

  post 'users/:id/follow',    to:"users#follow",    as:"follow"
  post 'users/:id/unfollow',  to:"users#unfollow",  as:"unfollow"
  post 'users/:id/accept',    to:"users#accept",    as:"accept"
  post 'users/:id/decline',   to:"users#decline",   as:"decline"
  post 'users/:id/cancel',    to:"users#cancel",    as:"cancel"

  get 'myposts', to: 'posts#myposts'
  get 'discover', to: 'posts#discover'
  get 'home/about'
  resources :posts
  root "posts#index"
  
end
