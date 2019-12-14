class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true, options: 'DEFAULT CHARSET=utf8'
  end
end
