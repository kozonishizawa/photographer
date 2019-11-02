class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.integer :subject, null:false
      t.date :date, null:false
      t.string :location, null:false
      t.text :request

      t.timestamps
    end
  end
end
