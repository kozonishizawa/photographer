class Front::RoomsController < ApplicationController
  before_action :login_required
  
  def show
    @room = Room.find_by(user_id: current_user.id)
    @messages = @room.messages
  end
end
