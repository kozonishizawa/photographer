class Admin::UsersController < Admin::ApplicationController
  before_action :required_admin

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to admin_users_url, flash: {success: "「#{@user.name}」を登録しました"}
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url, flash: {success: "「#{@user.name}」を更新しました"}
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, flash: {success: 'ユーザーを削除しました'}
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :tel, :admin, :password, :password_confirmation, :downloadable_limit, :activated)
    end

end
