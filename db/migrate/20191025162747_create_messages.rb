class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.boolean :admin, default: false, null:false

      t.timestamps
    end
  end
end
