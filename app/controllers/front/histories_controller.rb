class Front::HistoriesController < Front::PhotosController
  before_action :close_album, only: [:index, :show]
  before_action :overdue, only: [:show]
  
  def index
    @photos = Photo.re_selected.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where.not(status: 'closed')).reverse_order.page(params[:page]).per(20)
  end

  def show
    @photos = Photo.complete.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where(id: params[:id])).merge(Album.where.not(status: 'closed')).reverse_order.page(params[:page]).per(20)
    .or(Photo.re_selected.joins(album: :user).merge(User.where(id: current_user.id)).merge(Album.where(id: params[:id])).merge(Album.where.not(status: 'closed')).reverse_order.page(params[:page]).per(20))
  end

  def update
    photo = Photo.find(params[:id])
    if photo.complete?
      photo.update!(download_status: 're_selected')
    elsif photo.re_selected?
      photo.update!(download_status: 'complete')
    end
    render json: { status: :sccess }
  end

  private

  def photo_params
    params.require(:photo).permit :download_status
  end

end
