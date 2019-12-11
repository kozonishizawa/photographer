class Front::UsersController < Front::ApplicationController
  require 'zip'

  before_action :correct_user, only: [:edit, :update, :download]
  before_action :login_required, only: [:edit, :update]
  before_action :required_selection, only: [:download]

  def new
    @user = User.new
    @user.contacts.build
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
    redirect_to front_user_url(user), flash: { success: 'ユーザー情報を更新しました'}
  end

  def download
    photos = Photo.selected.joins(album: :user).merge(User.where(id: params[:user_id]))
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
    head :ok
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation, contacts_attributes: [:id, :subject, :date, :location, :request])
    end

    # 写真が選択されているか検証
    def required_selection
      photos = Photo.selected.joins(album: :user).merge(User.where(id: params[:user_id]))
      redirect_back(fallback_location: front_album_url(params[:album_id])) if photos.blank?
      flash[:danger] = '写真が選択されていません。'
    end

end
