Rails.application.routes.draw do

  root to: 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  # 管理画面
  namespace :admin do
    # 管理者メニュー
    root 'home#index'
    
    # ユーザー管理
    resources :users
    
    # アルバム管理
    resources :albums

    # 写真管理
    resources :photos

    # 記事
    resources :articles

    # チャット
    resources :rooms, only: [:index, :show]
    
    #お問い合わせ
    resources :contacts, only: [:index, :show]

  end

  # フロント
  namespace :front do
    # マイページ
    root 'home#index'

    #ユーザー
    resources :users, except: [:index, :destroy] do
      post :download
    end

    # 記事
    resources :articles, only: [:index, :show]

    # アルバム
    resources :albums, only: [:index, :show]

    # 写真
    resources :photos, only: [:update]

    # チャット
    resources :rooms, only: [:show]

    # お問い合わせ
    resources :contacts, only: [:index, :new, :create]
    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
