class AddContactStatusIdToContacts < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM contacts;'
    add_reference :contacts, :contact_status, index: true
  end

  def down
    remove_reference :contacts, :contact_status, index: true
  end
end
