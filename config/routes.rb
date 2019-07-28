Rails.application.routes.draw do
  resources :images
  resources :posts
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resource :users do
    member do
      get 'add_friend'
      delete 'remove_friend'
    end
    collection do
      get 'active_friends'
      get 'pending_friends'
      get 'received_friends'
    end
  end

  resources :news_feeds, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
