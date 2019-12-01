class Front::UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :required_contact, only: [:new, :create]
  before_action :login_required, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, flash: { info: 'アカウント有効化メールを送信いたしました。ご確認ください。' }
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    redirect_to admin_users_url, flash: { success: 'ユーザー情報を更新しました'}
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
    end

    def required_contact
      unless session[:contact_id]
        redirect_to new_front_contact_url, flash: { danger: '先にお問い合わせ内容を入力してください'}
      end
    end
end
