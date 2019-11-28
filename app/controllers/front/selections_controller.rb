class Front::SelectionsController < ApplicationController
  require 'zip'

  before_action :login_required
  before_action :validate_user

  def show
    @selection = Selection.find(params[:id])
    @photos = @selection.photos.reverse_order
    @album = @selection.album
  end

  def download_photos
    selection = Selection.find(params[:selection_id])
    photos = selection.photos
    album = selection.album
    # tempでzipファイルを生成
    t = Tempfile.new
    ::Zip::OutputStream.open(t.path) do |z|
      photos.each do |photo|
        z.put_next_entry("#{album.photographed_at}/#{photo.id}.jpg")
        z.print(photo.image.download)
      end
    end
    # ファイルダウンロード
    send_file(t.path, type: 'application/zip', dispositon: 'attachment', filename: 'photo_album.zip')
    # 閉じる
    t.close
  end

  def complete
  end

  private

    # ログイン中のユーザーを検証
    def validate_user
      user = User.joins(albums: :selection).merge(Selection.where(id: params[:id] || params[:selection_id])).first
      unless user === current_user
        redirect_to front_root_url, flash: { danger: 'アクセス権限がありません' }
      end
    end

end
