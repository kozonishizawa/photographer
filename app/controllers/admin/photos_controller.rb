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
    photo = Photo.create! photo_params
    render json: { status: :success, photo: photo }
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to admin_photo_url(@photo), flash: {success: "「#{@photo.title}」を更新しました"}
    else
      render :new
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.image.purge
    @photo.destroy
    head :no_content
  end

  private
    def photo_params
      params.require(:photo).permit :user_id, :album_id, :image
    end
end
