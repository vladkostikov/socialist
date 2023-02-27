Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"

  get '@:username', to: 'users#username'
  post 'users/follow', to: 'users#follow'
  delete 'users/unfollow', to: 'users#unfollow'
  post 'like', to: 'likes#like'
  delete 'dislike', to: 'likes#dislike'
  get 'bookmarks', to: 'bookmarks#index'
  post 'bookmarks', to: 'bookmarks#create'
  delete 'bookmarks', to: 'bookmarks#destroy'

  resources :comments, only: [:create, :edit, :update]
  resource :contacts, only: [:new, :create], path_names: { :new => '' }

  resources :users, only: [:show, :index] do
    resource :wall, only: [:create] do
      resources :articles, only: [:create]
    end
    get 'friends', to: 'users#friends'
    get 'subscriptions', to: 'users#subscriptions'
    get 'followers', to: 'users#followers'
  end

  resources :articles, except: [:new]
  resource :wall, only: [:create]
end
