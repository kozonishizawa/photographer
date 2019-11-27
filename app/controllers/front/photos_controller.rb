class Front::PhotosController < ApplicationController
  before_action :login_required
  before_action :verify_download_limit, only: [:update]
  
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    photo.update!(photo_params)
    redirect_to front_album_url(album.id)
    # head :no_content
  end
  
  private
  
  def verify_download_limit
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    if photo_params[:download_id].to_i === album.download.id
      if album.photos.where(download_id: album.download.id).count + 1 > album.download.downloadable_limit
        redirect_to front_album_url(album.id), flash: { danger: "選択できる写真は#{album.download.downloadable_limit}枚までです"}
      end
    end
  end

  def photo_params
    params.require(:photo).permit :download_id
  end
end
