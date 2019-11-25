class AddDownloadIdToPhotos < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM photos;'
    add_reference :photos, :download, index: true
  end

  def down
    remove_reference :photos, :download, index: true
  end
end
