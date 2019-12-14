class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change, options: 'DEFAULT CHARSET=utf8' do |t|
    add_index :users, :email, unique: true
  end
end
