class Front::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to front_root_url, flash: {info: 'アカウント有効化メールを送信いたしました。ご確認ください。'}
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
    end
end
