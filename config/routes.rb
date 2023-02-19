Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  get '/' => 'home#index'
  get '/about' => 'pages#about'
  get '@:username', to: 'users#username'

  resource :comments, only: [:create]

  resource :contacts, only: [:new, :create], path_names: { :new => '' }
  resource :terms, only: [:show]

  resources :users, only: [:show, :index] do
    resource :wall, only: [:create] do
      resources :articles, only: [:create]
    end
  end

  resources :articles, except: [:new]
  resource :wall, only: [:create]
  resources :likes, only: [:create]
end
