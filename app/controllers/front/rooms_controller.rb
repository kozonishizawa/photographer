class Front::RoomsController < ApplicationController
  before_action :login_required
  
  def show
    @room = Room.find current_user.id
    @messages = @room.messages
  end
end
