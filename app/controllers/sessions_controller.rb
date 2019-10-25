class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user.admin? ? admin_root_path : front_root_path, flash: {success: 'ログインしました'}
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
      params.require(:session).permit(:email, :password)
    end
    
end
