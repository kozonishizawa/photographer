class Front::AlbumsController < ApplicationController
  def index
    @albums = current_user.albums.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.order('created_at DESC')
  end
end
