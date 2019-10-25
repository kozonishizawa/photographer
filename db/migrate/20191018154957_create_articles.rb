class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
