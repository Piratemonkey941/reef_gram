Rails.application.routes.draw do
  resources :comments
  root "posts#index"
  get 'home/about'
  resources :posts

  devise_for :users
  devise_scope :user do
    get '/users',           to: 'devise/registration#new'
    get '/users/password',  to: 'devise/passwords#new'
    get '/users/sign_out'   => 'devise/sessions#destroy'
  end
  
  get 'myposts', to: 'posts#myposts'
  # get 'posts/myposts'
end
