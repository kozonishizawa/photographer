class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name, null:false
      t.string :email, null:false
      t.string :tel, null:false
      t.integer :subject, null:false
      t.date :date, null:false
      t.string :location, null:false
      t.text :request
      t.integer :approval, default: 0, null:false

      t.timestamps
    end
  end
end
