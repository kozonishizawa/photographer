class CreateDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :downloads do |t|
      t.boolean :paid, null: false, default: false
      t.integer :downloadable_limit
      t.integer :download_status, null: false, default: 0
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
