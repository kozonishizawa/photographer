class Front::AlbumsController < Front::ApplicationController
  before_action :login_required
  before_action :validate_user, only: [:show]

  def index
    @albums = current_user.albums.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.reverse_order
    @user = @album.user
  end

  private

    # ログイン中のユーザーを検証
    def validate_user
      album = Album.find(params[:id])
      user = album.user
      unless user.id === current_user.id
        redirect_to front_root_url, flash: { danger: 'アクセス権限がありません'}
      end
    end
    
end
