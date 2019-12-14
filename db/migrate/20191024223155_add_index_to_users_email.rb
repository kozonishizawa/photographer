class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, :unique => true, :name => 'index_users_email'
  end
end
