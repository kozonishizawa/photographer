class CreateDownloadItems < ActiveRecord::Migration[6.0]
  def change
    create_table :download_items do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :download, null: false, foreign_key: true

      t.timestamps
    end
  end
end
