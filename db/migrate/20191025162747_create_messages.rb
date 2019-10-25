class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|

      t.references :room, index: true, null: false
      t.text :content
      t.string :name
      
      t.timestamps
    end
  end
end
