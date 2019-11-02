class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      if user.activated?
        log_in(user)
        session_params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user.admin? ? admin_root_path : front_root_path, flash: {success: 'ログインしました'}
      else
        message = 'アカウントが有効ではありません'
        message += 'Eメールの有効化リンクにアクセスしてください'
        redirect_to root_url, flash: {warning: message}
      end
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが正しく入力されていません。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, flash: {success: 'ログアウトしました'}
  end

  private
    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
    
end
