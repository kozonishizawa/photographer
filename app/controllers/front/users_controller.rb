class Front::UsersController < ApplicationController
  require 'zip'

  before_action :correct_user, only: [:edit, :update, :download]
  before_action :required_contact, only: [:new, :create]
  before_action :login_required, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, flash: { info: 'アカウント有効化メールを送信いたしました。ご確認ください。' }
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    redirect_to admin_users_url, flash: { success: 'ユーザー情報を更新しました'}
  end

  def download
    photos = Photo.where(download_status: 'selected').joins(album: :user).merge(User.where(id: params[:user_id]))
    # tempでzipファイルを生成
    t = Tempfile.new
    ::Zip::OutputStream.open(t.path) do |z|
      photos.each do |photo|
        z.put_next_entry("photo_album/#{photo.id}.jpg")
        z.print(photo.image.download)
      end
    end
    # ファイルダウンロード
    send_file(t.path, type: 'application/zip', dispositon: 'attachment', filename: 'photo_album.zip')
    current_user.complete_download(photos)
    # 閉じる
    t.close
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
    end

    def required_contact
      unless session[:contact_id]
        redirect_to new_front_contact_url, flash: { danger: '先にお問い合わせ内容を入力してください'}
      end
    end
end
