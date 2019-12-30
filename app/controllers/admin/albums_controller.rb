class Admin::AlbumsController < Admin::ApplicationController
  before_action :required_admin

  def index
    @albums = Album.all
  end
  
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.order('created_at DESC')
  end

  def new
    @album = Album.new
    @users = User.all

  end

  def create
    @album = Album.create!(album_params)
    redirect_to admin_albums_url, flash: { success: 'アルバムを作成しました' }
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update album_params
    redirect_to admin_albums_url, flash: { success: 'アルバム情報を更新しました' }
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to admin_albums_url, flash: { success: 'アルバムを削除しました' }
  end

  private
  def album_params
    params.require(:album).permit :title, :description, :status, :photographed_at, :category, :user_id
  end

end
