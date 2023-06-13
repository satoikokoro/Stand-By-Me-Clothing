Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  devise_for :users,skip: [:passwords],  controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

#User側

 scope module: :public do

   root to:"homes#top"
   get 'about' => 'homes#about'

   resources :clothes

   resources :users, only: [:show,:edit,:update,]
   get 'users/withdraw' => 'users#withdraw'
   patch 'users/resign' => 'users#resign'

   resources :storages

   resources :favorites, only: [:create,:destroy]

   resources :comments, only: [:create,:destroy]

  end


#管理者側

  namespace :admin do

  root to:"homes#top"

  resources :users, only: [:index,:show,:edit,:update]

  resources :genres, only: [:index,:create,:edit,:update]

  resources :colors, only: [:index,:create,:edit,:update]

  resources :clothes,only: [:show]

  resources :comments, only: [:destroy]

  end
end