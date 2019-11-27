class CreateSelections < ActiveRecord::Migration[6.0]
  def change
    create_table :selections do |t|
      t.boolean :paid
      t.integer :downloadable_limit
      t.integer :download_status
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
