class Admin::RoomsController < ApplicationController
  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find params[:id]
    @messages = @user.messages
  end
end