class Front::PhotosController < ApplicationController
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    # ダウンロード可能限度を超えなければ更新
    photo.update!(photo_params)
    head :no_content
  end
  
  private
  
  def verify_download_limit(album)
    if photo_params[:download_id].to_i === album.download.id

      if album.photos.where(download_id: album.download.id).count > album.download.downloadable_limit
        redirect_to front_root_path, flash: { danger: '出直してこい'}
      end
      
    end
  end

  def photo_params
    params.require(:photo).permit :download_id
  end
end
