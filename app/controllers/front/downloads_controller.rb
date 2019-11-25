class Front::DownloadsController < ApplicationController
require 'zip'

  def show
    @download = Download.find(params[:id])
    @photos = @download.photos.reverse_order
    @album = @download.album
  end

  def download_photos
    download = Download.find(params[:download_id])
    photos = download.photos.reverse_order
    album = download.album
    # tempでzipファイルを生成
    t = Tempfile.new
    ::Zip::OutputStream.open(t.path) do |z|
      photos.each do |photo|
        z.put_next_entry("#{album.photographed_at}/#{photo.id}.jpg")
        z.print(photo.image.download)
      end
    end
    # ファイルダウンロード
    send_file(t.path, :type => 'application/zip', :dispositon => 'attachment', :filename => "photo_album.zip")
    # 閉じる
    t.close
  end
  
end
