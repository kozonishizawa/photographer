class AddUserIdToContact < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM contacts;'
    add_reference :contacts, :user, null: false, index: true
  end

  def down
    remove_reference :contacts, :user, index: true
  end
end
