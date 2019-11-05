class AddAlbumIdToPhotos < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM photos;'
    add_reference :photos, :album, null: false, index: true
  end

  def down
    remove_reference :photos, :album, index: true
  end

end
