Rails.application.routes.draw do

  scope module: 'user' do
    root :to => 'homes#top'
    devise_for :users, only: [:sessions, :registrations]

    resources :users, only: [:index, :show, :edit, :update] do
      get 'out_confirm' => 'users#out_confirm'
      patch 'out' => 'users#out'
    end
  end
end