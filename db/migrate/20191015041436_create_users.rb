class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false, limit: 191
      t.string :email, null: false, limit: 191
      t.string :tel, null:false, limit: 191
      t.string :password_digest, null: false, limit: 191
      t.boolean :admin, default: false, null:false

      t.timestamps
    end
  end
end
