class Front::RoomsController < ApplicationController
  def show
    @room = Room.find current_user.id
    @messages = @room.messages
  end
end
