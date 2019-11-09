class AddUserIdToRooms < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM rooms;'
    add_reference :rooms, :user, index: true
  end

  def down
    remove_reference :rooms, :user, index: true
  end
end
