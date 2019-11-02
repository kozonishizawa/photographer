class Admin::RoomsController < ApplicationController
  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find params[:id]
    admin_user = User.find_by(admin: true)
    @messages = @user.messages || admin_user.messages
  end
end