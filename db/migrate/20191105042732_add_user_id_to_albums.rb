class AddUserIdToAlbums < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM albums;'
    add_reference :albums, :user, index: true
  end

  def down
    remove_reference :albums, :user, index: true
  end
end
