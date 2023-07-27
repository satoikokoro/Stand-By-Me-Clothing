Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  devise_for :users,skip: [:passwords],  controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

#ゲストログイン
 devise_scope :user do
   post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
 end

#User側

 scope module: :public do

   root to:"homes#top"
   get 'about' => 'homes#about'

   get 'cloths/genre_search' => 'cloths#genre_search', as: "genre_search"

   resources :cloths do
     resource :favorites, only: [:create,:destroy]
     resources :comments, only: [:create,:destroy]
    end

    get 'users/withdraw' => 'users#withdraw'
    patch 'users/resign' => 'users#resign'

   resources :users, only: [:index,:show,:edit,:update,]
   resources :storages

   get "search" => "searches#search"

  end


#管理者側

  namespace :admin do

    root to:"homes#top"
    resources :users, only: [:index,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :colors, only: [:index,:create,:edit,:update]
    resources :cloths,only: [:index, :show, :destroy]
    resources :comments, only: [:destroy]

  end

end