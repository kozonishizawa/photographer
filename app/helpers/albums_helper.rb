module AlbumsHelper

  def downloadable_counter
    selected = Photo.where(download_status: 'selected').joins(album: :user).merge(User.where(id: current_user.id)).count
    selectable = current_user.downloadable_limit - selected
    if selectable >= 0
      return "あと#{selectable}枚選択できます"
    else 
      return "ダウンロード可能上限を#{selectable}超えています。"
    end
  end

end