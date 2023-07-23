Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
   root to: "homes#top"
   get 'users/:user_id/posts' => 'posts#index', as: 'user_posts'
   resources :users, only: [:index, :show, :edit, :update]
   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:destroy]
   end
  end

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/confirmation' => 'users#confirmation', as: 'confirm_confirmation'
    put 'users/information' => 'users#update'
    patch 'users/withdrawal' => 'users#withdrawal', as: 'withdrawal_user'
    get "search" => "searches#search"
    get 'users/favorites' => 'users#favorites', as: 'favorited_posts'
    resources :posts, only:[:edit, :index, :show, :create, :update, :new, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
