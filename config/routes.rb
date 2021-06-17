Rails.application.routes.draw do
  
  
  namespace :admin do
    get 'searches/search'
  end
  scope module: 'user' do
    root :to => 'homes#top'
    get 'search' => 'searches#search'

    devise_for :users, only: [:sessions, :registrations],controllers: { 
      :registrations =>  'user/registrations',
    }

    resources :users, only: [:index, :show, :edit, :update] do
      get 'out_confirm' => 'users#out_confirm'
      patch 'out' => 'users#out'
    end

    resources :groups, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      get 'join' => 'groups#join'
      delete 'groupout' => 'groups#groupout'
      resource :group_users, only: [:create, :destroy] 
        resources :posts, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
         resource :likes, only: [:create, :destroy]
        end
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in' => 'user/sessions#guest_sign_in'
  end


  devise_for :admins, path: '/admin', only: [:sessions], controllers: { :sessions => 'admin/sessions'}
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    get 'search' => 'searches#search'
  end
  

end