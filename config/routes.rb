Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
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
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
