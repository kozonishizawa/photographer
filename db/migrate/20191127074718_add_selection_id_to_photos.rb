class AddSelectionIdToPhotos < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM photos;'
    add_reference :photos, :selection, index: true
  end

  def down
    remove_reference :photos, :selection, index: true
  end
end
