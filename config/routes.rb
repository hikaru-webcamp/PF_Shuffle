Rails.application.routes.draw do
  scope module: "user" do
    root :to => "homes#top"
    get "search" => "searches#search"

    devise_for :users, only: [:sessions, :registrations], controllers: {
                         :registrations => "user/registrations",
                       }

    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy] do
        get "following"
        get "follower"
      end
      get "post_index" => "users#post_index"
      get "group_in" => "users#group_in"
      patch "out" => "users#out"
    end

    resources :groups, only: [:index, :show, :create, :update, :destroy] do
      collection do
        get "group_post_index" => "groups#group_post_index"
      end
      get "join" => "groups#join"
      delete "groupout" => "groups#groupout"
      get "group_post" => "groups#groupout"
      resources :posts, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
        resource :likes, only: [:create, :destroy]
        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end

  devise_scope :user do
    post "users/guest_sign_in" => "user/sessions#guest_sign_in"
  end

  devise_for :admins, path: "/admin", only: [:sessions], controllers: { :sessions => "admin/sessions" }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    get "search" => "searches#search"
  end
end
