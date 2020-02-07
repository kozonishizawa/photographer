class Front::PhotosController < Front::ApplicationController
  # include AjaxHelper
  before_action :login_required
  before_action :validate_user, only: [:update]
  before_action :verify_downloadable_limit, only: [:update]
  
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    if photo.download_status == 'unselected'
      photo.update!(download_status: 'selected')
    elsif photo.download_status == 'selected'
      photo.update!(download_status: 'unselected')
    end
    selected = Photo.selected.joins(album: :user).merge(User.where(id: current_user.id)).count
    selectable = current_user.downloadable_limit - selected
    render json: { status: :sccess, selectable: selectable }
  end

  private

    # ログイン中のユーザーを検証
    def validate_user
      user = User.joins(albums: :photos).merge(Photo.where(id: params[:id])).first
      unless user.id === current_user.id
        redirect_to front_album_url(current_user.album.id),flash: { danger: 'アクセス権限がありません' }
      end
    end

    # ダウンロード上限を検証
    def verify_downloadable_limit
      photo = Photo.find(params[:id])
      selected_quantity = Photo.selected.where(user_id: current_user.id).count
      if selected_quantity >= current_user.downloadable_limit && photo.download_status == 'unselected'
        render json: { selectable: 'over' }
      end
    end

    def photo_params
      params.require(:photo).permit :download_status
    end

end
