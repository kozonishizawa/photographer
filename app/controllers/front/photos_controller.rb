class Front::PhotosController < ApplicationController
  before_action :login_required
  before_action :verify_downloadable_limit, only: [:update]
  
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    photo.update!(photo_params)
    redirect_to front_album_url(album.id)
    # head :no_content
  end
  
  private
  
    def verify_downloadable_limit
      photo = Photo.find(params[:id])
      album = Album.find(photo.album.id)
      if photo_params[:selection_id].to_i === album.selection.id
        if album.photos.where(selection_id: album.selection.id).count + 1 > album.selection.downloadable_limit
          redirect_to front_album_url(album.id), flash: { danger: "選択できる写真は#{album.selection.downloadable_limit}枚までです"}
        end
      end
    end

    def photo_params
      params.require(:photo).permit :selection_id
    end
    
end
