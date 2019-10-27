class Admin::RoomsController < ApplicationController
  def index
    Room.create! if Room.first.blank?
    @rooms = Room.all.order(:id)
  end

  def show
    @room = Room.find params[:id]
    @messages = @room.messages
  end
end
