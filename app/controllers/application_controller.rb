class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_current_user

  # ログイン中のユーザー
  def set_current_user
  	@current_user = User.find_by(id: session[:user_id])
  end

  # ログイン検証
  def login_required
    store_location
    redirect_to login_url, flash: { danger: 'ログインが必要です' } unless current_user
  end

  def forbid_login_user
    redirect_back_or root_url, flash: { danger: 'すでにログインしています' } if current_user
  end

  # 管理者検証
  def required_admin
    redirect_to root_url, flash: { danger: 'アクセス権限がありません' } unless current_user&.admin?
  end

  # ユーザー検証
  def correct_user
    @user = User.find(params[:id] || params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # アルバム公開期限
  def deadline(album)
    album.created_at.to_date + album.open_period
  end

  # 公開期間の徒過を検証
  def overdue
    album = Album.find(params[:id])
    if deadline(album).past?
      redirect_to front_albums_url, flash: { danger: 'アルバムの公開期間は終了しています' } 
    end
  end

  # 公開期間終了したアルバムを非公開にする
  def close_album
    albums = current_user.albums.where.not(status: :closed)
    albums.each do |album|
      if deadline(album).past?
        album.closed!
      end
    end
  end

end
