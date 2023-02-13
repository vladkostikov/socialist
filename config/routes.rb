Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  get '/' => 'home#index'
  get '/about' => 'pages#about'

  resources :articles
  resource :comments, only: [:create]

  resource :contacts, only: [:new, :create], path_names: { :new => '' }
  resource :terms, only: [:show]
  resources :users, only: [:show, :index]
end
