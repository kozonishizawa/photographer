module AlbumsHelper

  def downloadable_counter(selection)
    counter = selection.downloadable_limit - selection.photos.count
    return "あと#{counter}枚選択できます"
  end

end