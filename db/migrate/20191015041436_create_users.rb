class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :tel, null:false
      t.string :password_digest, null: false
      t.boolean :admin, default: false, null:false

      t.timestamps
    end
  end
end
