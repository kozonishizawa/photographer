class Front::PhotosController < Front::ApplicationController

  before_action :login_required
  before_action :validate_user, only: [:update]
  before_action :verify_downloadable_limit, only: [:update]

  def index
    @photos = Photo.selected.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where.not(status: 'closed'))
  end
  
  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    case photo.download_status
    when 'unselected'
      photo.update!(download_status: 'selected')
    when 'selected'
      photo.update!(download_status: 'unselected')
    else
      return false
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
