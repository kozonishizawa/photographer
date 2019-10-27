Rails.application.routes.draw do

  root to: 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # 管理画面
  namespace :admin do
    # 管理者メニュー
    root 'home#index'
    
    # ユーザー管理
    resources :users
    
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
    resources :users, except: [:index]

    # 記事
    resources :articles, only: [:index, :show]

    # お問い合わせ
    resources :contacts, only: [:new, :create]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
