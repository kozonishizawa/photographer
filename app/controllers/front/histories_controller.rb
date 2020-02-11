class Front::HistoriesController < Front::PhotosController
  def index
    @photos = Photo.re_selected.joins(album: :user).merge(User.where(id: current_user.id)).reverse_order
  end

  def show
    @photos = Photo.complete.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where(id: params[:id])).reverse_order
    .or(Photo.re_selected.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where(id: params[:id])).reverse_order)
  end

  def update
    photo = Photo.find(params[:id])
    album = Album.find(photo.album.id)
    case photo.download_status
    when 'complete'
      photo.update!(download_status: 're_selected')
    when 're_selected'
      photo.update!(download_status: 'complete')
    else
      return false
    end
    render json: { status: :sccess }
  end

  private

  def photo_params
    params.require(:photo).permit :download_status
  end

end
