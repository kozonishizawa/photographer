class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_current_user

  # ログイン中のユーザー
  def set_current_user
  	@current_user = User.find_by(id: session[:user_id])
  end

  def login_required
    redirect_to login_path, flash: {danger: 'ログインが必要です'} unless current_user
  end

  def forbid_login_user
    redirect_back_or root_path, flash: {danger: 'すでにログインしています'} if current_user
  end
  
  def required_admin
    redirect_to root_path, flash: {danger: 'アクセス権限がありません'} unless current_user&.admin?
  end
end
