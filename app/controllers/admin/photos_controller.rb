class Admin::PhotosController < ApplicationController
  before_action :required_admin

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
    @users = User.all
  end

  def create
    @photo = Photo.create!(photo_params)
    redirect_to admin_photos_path, flash: {success: "写真を登録しました"}
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to admin_photo_path(@photo), flash: {success: "「#{@photo.title}」を更新しました"}
    else
      render :new
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.images.purge
    @photo.destroy
    redirect_to admin_photos_url, flash: {success: '写真を削除しました'}
  end

  private
    def photo_params
      params.require(:photo).permit(:title, :description, :status, :user_id, images: [])
    end
end
