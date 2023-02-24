Rails.application.routes.draw do
  root "posts#index"
  get 'home/about'
  resources :posts

  devise_for :users
  devise_scope :user do
    get '/users',           to: 'devise/registration#new'
    get '/users/password',  to: 'devise/passwords#new'
    get '/users/sign_out'   => 'devise/sessions#destroy'
  end
  
  get 'my_posts', to: 'posts#my_posts'
  # get 'posts/myposts'
end
