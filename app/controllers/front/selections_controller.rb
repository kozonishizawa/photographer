class Front::SelectionsController < ApplicationController
  require 'zip'

  before_action :login_required

  def show
    @selection = Selection.find(params[:id])
    @photos = @selection.photos.reverse_order
    @album = @selection.album
  end

  def selection_photos
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

end
