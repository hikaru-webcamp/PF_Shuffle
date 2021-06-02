Rails.application.routes.draw do
  scope module: 'user' do
    root :to => 'homes#top'

    devise_for :users, only: [:sessions, :registrations]

    resources :users, only: [:index, :show, :edit, :update] do
      get 'out_confirm' => 'users#out_confirm'
      patch 'out' => 'users#out'
    end

    resources :groups, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      resources :group_users, only: [:create, :destroy] 
        resources :posts, only: [:create, :destroy] do
         resource :likes, [:create, :destroy]
        end
    end
    
  end

  devise_for :admins, path: '/admin', only: [:sessions], controllers: { :sessions => 'admin/sessions'}
  namespace :admin do
    root :to => 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
  end
  
end
