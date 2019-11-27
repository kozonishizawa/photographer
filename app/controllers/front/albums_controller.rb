class Front::AlbumsController < ApplicationController
  before_action :login_required

  def index
    @albums = current_user.albums.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.reverse_order
    @selection = @album.selection
  end
end
