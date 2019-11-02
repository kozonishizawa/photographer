class AddUserIdToMessages < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM messages;'
    add_reference :messages, :user, null: false, index: true
  end

  def down
    remove_reference :messages, :user, index: true
  end
end
