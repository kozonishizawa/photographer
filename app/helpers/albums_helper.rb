module AlbumsHelper

  def downloadable_counter
    selected = Photo.selected.joins(album: :user).merge(User.where(id: current_user.id)).count
    selectable = current_user.downloadable_limit.to_i - selected
    if selectable >= 0
      return selectable
    else 
      return "ダウンロード可能上限を超えています。"
    end
  end

end 