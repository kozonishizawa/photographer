class UsersController < ApplicationController
  def new
    @user = User.new
    @user.contacts.build
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation, contacts_attributes: [:id, :subject, :date, :location, :request, :contact_status_id])
  end

end
