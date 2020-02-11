class Front::AlbumsController < Front::ApplicationController
  before_action :login_required
  before_action :validate_user, only: [:show]
  before_action :close_album, only: [:index]
  before_action :overdue, only: [:show]

  def index
    @albums = current_user.albums.where.not(status: 'close')
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
        redirect_to front_root_url, flash: { danger: 'アクセス権限がありません' }
      end
    end
    # 公開期間終了したアルバムを非公開にする
    def close_album
      albums = current_user.albums.where.not(status: 'close')
      albums.each do |album|
        deadline = album.created_at.to_date + album.open_period
        if deadline < Date.today
          album.update!(status: 'closed')
        end
      end
    end
    # 公開期間の徒過を検証
    def overdue
      album = Album.find(params[:id])
      deadline = album.created_at.to_date + album.open_period
      if deadline < Date.today
        redirect_to front_albums_url, flash: { danger: 'アルバムの公開期間は終了しています' } 
      end
    end
    
end
