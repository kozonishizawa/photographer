class Front::DownloadsController < ApplicationController

  def show
    @album = find(params[:id])
    @download_items = @album.download_items.all
  end

  def update
  end
  
end
