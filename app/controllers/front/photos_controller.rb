class Front::PhotosController < ApplicationController
  before_action :login_required
  before_action :validate_user, only: [:update]
  before_action :verify_downloadable_limit, only: [:update]
  
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    photo.update!(photo_params)
    head :ok
  end
  
  private
  
    # ダウンロード上限を検証
    def verify_downloadable_limit
      photo = Photo.find(params[:id])
      album = Album.find(photo.album.id)
      if photo_params[:selection_id].to_i === album.selection.id
        if album.photos.where(selection_id: album.selection.id).count >= album.selection.downloadable_limit
          redirect_to front_album_url(album.id), flash: { danger: "選択できる写真は#{album.selection.downloadable_limit}枚までです"}
        end
      end
    end

    # ログイン中のユーザーを検証
    def validate_user
      user = User.joins(albums: :photos).merge(Photo.where(id: params[:id])).first
      unless user.id === current_user.id
        redirect_to front_album_url(current_user.album.id),flash: { danger: 'アクセス権限がありません' }
      end
    end

    def photo_params
      params.require(:photo).permit :selection_id
    end

end
