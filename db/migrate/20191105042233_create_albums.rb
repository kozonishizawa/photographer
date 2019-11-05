class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.integer :category, default: 0
      t.date :photographed_at

      t.timestamps
    end
  end
end
