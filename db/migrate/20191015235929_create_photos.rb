class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
