 Rails.application.routes.draw do
   devise_for :users
  get 'likes/new'
  get 'comments/new'
  
   resources :users, only: [:index, :show] do
     resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
     end 
  end

  root 'users#index'
end
