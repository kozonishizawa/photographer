class AddRoomIdToMessages < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM messages;'
    add_reference :messages, :room, index: true
  end

  def down
    remove_reference :messages, :room, index: true
  end
end
